#!/bin/sh
repo_local='localhost:5001' 
docker pull $1
docker tag $1 $repo_local/$2
docker push $repo_local/$2