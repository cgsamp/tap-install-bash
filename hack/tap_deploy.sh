#!/bin/bash
#set -euxo pipefail

export KUBECONFIG_FILE="../secrets/csamp-user-aks.kubeconfig"
export TAP_REGISTRY_VERSION=1.0.1-build.7
export TAP_VERSION=1.0.1-build.7
source ../secrets/registry_credentials.sh
source ../secrets/tanzunet_credentials.sh

source connect_to_kube.sh
source cluster_essentials.sh
source tanzu_cli.sh
source add_tap_repository.sh
source install_tap.sh
source developer_namespace.sh
source test_workload.sh