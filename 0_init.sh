#!/bin/sh
set -o errexit

# create registry container unless it already exists
reg_name='kind-registry'
reg_port='5001'

repo_local='localhost:5001' 

if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then
  docker run \
    -d --restart=always -p "127.0.0.1:${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi


docker pull hyperledger/besu
docker tag hyperledger/besu $repo_local/hyperledger/besu
docker push $repo_local/hyperledger/besu

docker pull prom/prometheus:v2.11.1
docker tag prom/prometheus:v2.11.1 $repo_local/prom/prometheus:v2.11.1
docker push $repo_local/prom/prometheus:v2.11.1

docker pull grafana/grafana:6.2.5
docker tag grafana/grafana:6.2.5 $repo_local/grafana/grafana:6.2.5
docker push $repo_local/grafana/grafana:6.2.5

docker pull quay.io/metallb/speaker:v0.12.1
docker tag quay.io/metallb/speaker:v0.12.1 $repo_local/metallb/speaker:v0.12.1
docker push $repo_local/metallb/speaker:v0.12.1

docker pull quay.io/metallb/controller:v0.12.1
docker tag quay.io/metallb/controller:v0.12.1 $repo_local/metallb/controller:v0.12.1
docker push $repo_local/metallb/controller:v0.12.1

docker pull pegasyseng/k8s-helper:v1.18.4
docker tag pegasyseng/k8s-helper:v1.18.4 $repo_local/pegasyseng/k8s-helper:v1.18.4
docker push $repo_local/pegasyseng/k8s-helper:v1.18.4

docker pull k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1@sha256:64d8c73dca984af206adf9d6d7e46aa550362b1d7a01f3a0a91b20cc67868660
docker tag k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1@sha256:64d8c73dca984af206adf9d6d7e46aa550362b1d7a01f3a0a91b20cc67868660 $repo_local/ingress-nginx/kube-webhook-certgen:v1.1.1
docker push $repo_local/ingress-nginx/kube-webhook-certgen:v1.1.1

docker pull k8s.gcr.io/ingress-nginx/controller:v1.2.0@sha256:d8196e3bc1e72547c5dec66d6556c0ff92a23f6d0919b206be170bc90d5f9185
docker tag k8s.gcr.io/ingress-nginx/controller:v1.2.0@sha256:d8196e3bc1e72547c5dec66d6556c0ff92a23f6d0919b206be170bc90d5f9185 $repo_local/ingress-nginx/controller:v1.2.0
docker push $repo_local/ingress-nginx/controller:v1.2.0

helm plugin install https://github.com/databus23/helm-diff