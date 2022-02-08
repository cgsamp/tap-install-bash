#!/bin/bash
set -euo pipefail

# Edit these values appropriately
export KUBECONFIG_FILE="../secrets/csamp-tap-aks.kubeconfig"
export TAP_REGISTRY_VERSION=1.0.1-build.7
export TAP_VERSION=1.0.1-build.7

# Be sure to update the below credential files
source ../secrets/registry_credentials.sh
source ../secrets/tanzunet_credentials.sh

## No edits below here necessary; can (un)comment lines if needed
source ./sources/connect_to_kube.sh
source ./sources/cluster_essentials.sh
source ./sources/tanzu_cli.sh
source ./sources/add_tap_repository.sh
source ./sources/install_tap.sh
source ./sources/developer_namespace.sh
source ./sources/test_workload.sh