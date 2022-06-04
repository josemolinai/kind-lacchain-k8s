#!/bin/sh
sudo rm -fR /mnt/lacchain-k8s/
sudo mkdir -p /mnt/lacchain-k8s/node0/monitoring
sudo mkdir -p /mnt/lacchain-k8s/node1/validator/1
sudo mkdir -p /mnt/lacchain-k8s/node1/validator/2
sudo mkdir -p /mnt/lacchain-k8s/node1/boot/1

sudo mkdir -p /mnt/lacchain-k8s/node2/validator/3
sudo mkdir -p /mnt/lacchain-k8s/node2/validator/4
sudo mkdir -p /mnt/lacchain-k8s/node2/boot/2