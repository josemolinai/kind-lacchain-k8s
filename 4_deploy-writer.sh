kubectl apply -f ./writer/besu-config-toml-configmap-writer.yaml
kubectl apply -f ./writer/writernode-statefulset.yaml
kubectl apply -f ./writer/writernode-service.yaml
kubectl apply -f ./writer/writernode-statefulset-ethstats.yaml
