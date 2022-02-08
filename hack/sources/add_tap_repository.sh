#!/bin/bash
set -euo pipefail

export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
source ../secrets/tanzunet_credentials.sh

kubectl create ns tap-install || true

tanzu secret registry add tap-registry \
  --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} \
  --server ${INSTALL_REGISTRY_HOSTNAME} \
  --export-to-all-namespaces --yes --namespace tap-install

tanzu package repository add tanzu-tap-repository \
  --url registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:$TAP_REGISTRY_VERSION \
  --namespace tap-install

tanzu package available list --namespace tap-install

echo "$(tput bold)Tanzu registry installed $(tput sgr0)"