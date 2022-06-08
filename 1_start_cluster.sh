#!/bin/sh
set -o errexit

# create registry container unless it already exists
reg_name='kind-registry'
reg_port='5001'



# create a cluster with the local registry enabled in containerd
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: lacchain-k8s
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:${reg_port}"]
    endpoint = ["http://${reg_name}:5000"]
networking:
  ipFamily: ipv4
  apiServerAddress: "127.0.0.1"
  apiServerPort: 6443
  podSubnet: "10.244.0.0/16"
  serviceSubnet: "10.96.0.0/12"
  kubeProxyMode: "iptables"
  disableDefaultCNI: false
nodes:
- role: control-plane
  image: localhost:5001/kindest/node:v1.24.0
  extraMounts:
  - hostPath: /mnt/lacchain-k8s/node0/monitoring/
    containerPath: /mnt/data/
    readOnly: false
    selinuxRelabel: false
    propagation: None
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    listenAddress: "0.0.0.0"
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    listenAddress: "0.0.0.0"
    protocol: TCP
- role: worker
  image: localhost:5001/kindest/node:v1.24.0
  extraMounts:
  - hostPath: /mnt/lacchain-k8s/node1/validator/1/
    containerPath: /mnt/data/validator/1/
    readOnly: false
    selinuxRelabel: false
    propagation: None
  - hostPath: /mnt/lacchain-k8s/node1/validator/2/
    containerPath: /mnt/data/validator/2/
    readOnly: false
    selinuxRelabel: false
    propagation: None
  - hostPath: /mnt/lacchain-k8s/node1/boot/1/
    containerPath: /mnt/data/boot/1/
    readOnly: false
    selinuxRelabel: false
    propagation: None 
- role: worker
  image: localhost:5001/kindest/node:v1.24.0
  extraMounts:
  - hostPath: /mnt/lacchain-k8s/node1/validator/3/
    containerPath: /mnt/data/validator/3/
    readOnly: false
    selinuxRelabel: false
    propagation: None
  - hostPath: /mnt/lacchain-k8s/node1/validator/4/
    containerPath: /mnt/data/validator/4/
    readOnly: false
    selinuxRelabel: false
    propagation: None
  - hostPath: /mnt/lacchain-k8s/node1/boot/2/
    containerPath: /mnt/data/boot/2/
    readOnly: false
    selinuxRelabel: false
    propagation: None             
EOF

# connect the registry to the cluster network if not already connected
if [ "$(docker inspect -f='{{json .NetworkSettings.Networks.kind}}' "${reg_name}")" = 'null' ]; then
  docker network connect "kind" "${reg_name}"
fi

# Document the local registry
# https://github.com/kubernetes/enhancements/tree/master/keps/sig-cluster-lifecycle/generic/1755-communicating-a-local-registry
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: local-registry-hosting
  namespace: kube-public
data:
  localRegistryHosting.v1: |
    host: "localhost:${reg_port}"
    help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
EOF
kubectl apply -f ./cluster/nginx-controller.yaml


kubectl label nodes lacchain-k8s-control-plane --overwrite monitoring=true
kubectl label nodes lacchain-k8s-worker --overwrite  bootnode-1=true validator-1=true validator-2=true writer-1=true
kubectl label nodes lacchain-k8s-worker2 --overwrite bootnode-2=true validator-3=true validator-4=true writer-2=true
kubectl create namespace metallb-system

kubectl apply -n metallb-system -f metallb/metallb-configmap.yaml
kubectl apply -n metallb-system -f metallb/metallb.yaml
kubectl get pods -n metallb-system --watch


