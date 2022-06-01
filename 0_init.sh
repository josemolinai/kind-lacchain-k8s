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