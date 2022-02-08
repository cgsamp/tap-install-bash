#!/bin/bash
set -euo pipefail

ARCH=darwin  #  darwin | linux | windows

echo ###(RE)INSTALLING TANZU CLI###
mkdir $HOME/tanzu || true
rm -rf $HOME/tanzu/cli
tar -xf ../lib/tanzu-framework-$ARCH-amd64.tar -C $HOME/tanzu

WORKING_DIRECTORY=$(pwd)
cd $HOME/tanzu
export TANZU_CLI_NO_INIT=true
tanzu update --local ./cli
tanzu version
tanzu plugin delete imagepullsecret || true
rm -rf ~/Library/Application\ Support/tanzu-cli/*
tanzu plugin install --local cli all
tanzu plugin list
cd $WORKING_DIRECTORY
echo "$(tput bold)Tanzu CLI updated $(tput sgr0)"