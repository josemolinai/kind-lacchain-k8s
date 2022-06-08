#!/bin/sh
set -o errexit

# create registry container unless it already exists
reg_name='kind-registry'
reg_port='5001'
reg_host='0.0.0.0'

repo_local='localhost:5001' 

if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then
  docker run \
    -d --restart=always -p "${reg_host}:${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi

#Base
cd docker
./preload_base.sh
cd ..
helm plugin install https://github.com/databus23/helm-diff