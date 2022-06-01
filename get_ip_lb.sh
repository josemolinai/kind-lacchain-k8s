#!/bin/sh
LB_IP=$(kubectl -n lacchain-network get svc/writers-lb -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $LB_IP