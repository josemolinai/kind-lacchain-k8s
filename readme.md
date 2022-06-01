# Deploy LACChain Besu Network into kind cluster

For testing purposes only.Deploy a lacchain Network Based in [lacchain-k8s](https://github.com/lacchain/lacchain-k8s)

## Prerequisites
- [Kubernetes](https://kubernetes.io/) 1.12+
- [Helm](https://helm.sh/docs/)
- [helmfile](https://github.com/roboll/helmfile)
- [Helm Diff plugin](https://github.com/databus23/helm-diff)
- [Ansible](https://www.ansible.com/)


## Installing the Chart
To install the chart in the namesapce with the name `lacchain-network`:
```bash
helmfile -n lacchain-network -f helmfile.yaml apply
```


## Copyright 2020 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
