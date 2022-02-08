#!/bin/bash
set -euo pipefail

tanzu apps workload delete tanzu-java-web-app --yes
tanzu apps workload create tanzu-java-web-app --git-repo https://github.com/sample-accelerators/tanzu-java-web-app --git-branch main --type web --label app.kubernetes.io/part-of=tanzu-java-web-app --yes
tanzu apps workload tail tanzu-java-web-app --since 10m --timestamp

INGRESS_IP=$(kubectl get service -n tanzu-system-ingress -o=jsonpath='{.items[?(@.metadata.name=="envoy")].status.loadBalancer.ingress[0].ip}')

echo
echo Reminder
echo "$(tput bold)The tanzu system ingress envoy ingress loadbalancer ip is $INGRESS_IP"
echo You can test the new app with 
echo  curl --resolve [your domain]:80:$INGRESS_IP tanzu-java-web-app.default.apps.tap.[your domain]
echo "Update your DNS! $(tput sgr0)"
