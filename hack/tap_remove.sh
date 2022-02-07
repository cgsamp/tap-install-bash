#!/bin/bash
set -euxo pipefail

export TAP_REGISTRY_VERSION=1.0.1-build.7
export TAP_VERSION=1.0.1-build.7

tanzu package installed delete tap -p tap.tanzu.vmware.com -v $TAP_VERSION -n tap-install
kubectl delete namespace tap-install
