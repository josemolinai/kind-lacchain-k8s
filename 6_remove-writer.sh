
kubectl delete -f ./writer/writernode-statefulset-ethstats.yaml
kubectl delete -f ./writer/writernode-service.yaml
kubectl delete -f ./writer/writernode-statefulset.yaml
kubectl delete -f ./writer/besu-config-toml-configmap-writer.yaml