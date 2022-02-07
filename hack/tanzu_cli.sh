#!/bin/bash
#set -euxo pipefail

ARCH=darwin  #  darwin | linux | windows

echo ###(RE)INSTALLING TANZU CLI###
mkdir $HOME/tanzu
rm -rf $HOME/tanzu/cli
tar -xvf ../lib/tanzu-framework-$ARCH-amd64.tar -C $HOME/tanzu
cd $HOME/tanzu
export TANZU_CLI_NO_INIT=true
tanzu update --local ./cli
tanzu version
tanzu plugin delete imagepullsecret
rm -rf ~/Library/Application\ Support/tanzu-cli/*
tanzu plugin install --local cli all
tanzu plugin list