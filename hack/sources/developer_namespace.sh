#!/bin/bash
set -euo pipefail
source ../secrets/registry_credentials.sh
#tanzu secret registry delete registry-credentials --yes
#tanzu secret registry add registry-credentials --server $REGISTRY_SERVER --username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD --namespace default
pwd
kubectl -n default apply -f ./sources/developer_namespace.yaml
echo "$(tput bold)Developer namespace created $(tput sgr0)"
