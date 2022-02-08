#!/bin/bash
set -euo pipefail

echo ### UPDATING KUBECONFIG AND CONNECTING TO CLUSTER ###
CONTEXT=$(kubectl config view --kubeconfig $KUBECONFIG_FILE -ojson | jq -r '.contexts[].name')
echo "Found $CONTEXT in $KUBECONFIG_FILE"

if [ -v ${KUBECONFIG+x} ]; then 
    KUBECONFIG=''; 
fi

OLD_KUBECONFIG=$KUBECONFIG
if [[ $OLD_KUBECONFIG == "" ]]; then
    OLD_KUBECONFIG=~/.kube/config;
fi

echo "Deleting $CONTEXT in $OLD_KUBECONFIG if exists"
kubectl config delete-context $CONTEXT --kubeconfig ~/.kube/config
echo Merging $CONTEXT in $KUBECONFIG_FILE with $OLD_KUBECONFIG

export KUBECONFIG=$OLD_KUBECONFIG:$KUBECONFIG_FILE
kubectl config view --flatten > ../secrets/merged.kubeconfig
cp ../secrets/merged.kubeconfig ~/.kube/config
export KUBECONFIG=$OLD_KUBECONFIG
kubectl config use-context $CONTEXT

K_APISERVER=$(kubectl get all -ojson | jq -r '.items[] | select(.kind=="Service") | select (.metadata.name=="kubernetes") | .metadata.labels.component')
if [ $K_APISERVER != "apiserver" ]; then
    echo Problem finding Service/kubernetes
    kubectl get all
    exit 1;
fi
echo "$(tput bold)Service/kubernetes verified UP in namespace default $(tput sgr0)"