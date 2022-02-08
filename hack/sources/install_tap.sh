#!/bin/bash
set -euo pipefail

tanzu package install tap -p tap.tanzu.vmware.com -v $TAP_VERSION --values-file ../tap-values.yaml -n tap-install
tanzu package installed list -n tap-install

INGRESS_IP=$(kubectl get service -n tanzu-system-ingress -o=jsonpath='{.items[?(@.metadata.name=="envoy")].status.loadBalancer.ingress[0].ip}')

echo "$(tput bold)The tanzu system ingress envoy ingress loadbalancer ip is $INGRESS_IP $(tput sgr0)"
echo "$(tput bold)Update your DNS! $(tput sgr0)"

