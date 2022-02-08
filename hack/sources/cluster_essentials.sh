#!/bin/bash
set -euo pipefail

echo ### INSTALLING CLUSTER ESSENTIALS ###
rm -rf ./tanzu-cluster-essentials
mkdir ./tanzu-cluster-essentials
tar -xf ../lib/tanzu-cluster-essentials-darwin-amd64-1.0.0.tgz -C ./tanzu-cluster-essentials
export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com

cd ./tanzu-cluster-essentials
./install.sh
cd ..
echo "$(tput bold)Cluster Essentials installed $(tput sgr0)"
