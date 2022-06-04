#!/bin/sh

docker pull kindest/node:v1.24.0@sha256:0866296e693efe1fed79d5e6c7af8df71fc73ae45e3679af05342239cdc5bc8e

./preload.sh hyperledger/besu hyperledger/besu
./preload.sh prom/prometheus:v2.11.1 prom/prometheus:v2.11.1
./preload.sh grafana/grafana:6.2.5 grafana/grafana:6.2.5
./preload.sh quay.io/metallb/speaker:v0.12.1 metallb/speaker:v0.12.1
./preload.sh quay.io/metallb/controller:v0.12.1 metallb/controller:v0.12.1
./preload.sh pegasyseng/k8s-helper:v1.18.4 pegasyseng/k8s-helper:v1.18.4
./preload.sh k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1@sha256:64d8c73dca984af206adf9d6d7e46aa550362b1d7a01f3a0a91b20cc67868660 ingress-nginx/kube-webhook-certgen:v1.1.1
./preload.sh k8s.gcr.io/ingress-nginx/controller:v1.2.0@sha256:d8196e3bc1e72547c5dec66d6556c0ff92a23f6d0919b206be170bc90d5f9185 ingress-nginx/controller:v1.2.0
./preload.sh lacnetnetworks/relay-signer-lacchain:1.0.0 lacnetnetworks/relay-signer-lacchain:1.0.0
./preload.sh lacnetnetworks/writer-nginx-lacchain:1.0.0 lacnetnetworks/writer-nginx-lacchain:1.0.0
./preload.sh lacnetnetworks/lacchain-besu:21.1.6 lacnetnetworks/lacchain-besu:21.1.6
./preload.sh alethio/ethstats-cli alethio/ethstats-cli