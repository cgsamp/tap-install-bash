#!/bin/bash
#set -euxo pipefail
source ../secrets/azure_creds.sh
tanzu secret registry delete registry-credentials --yes
tanzu secret registry add registry-credentials --server $REGISTRY_SERVER --username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD --namespace default
kubectl -n default apply -f developer_namespace.yaml
