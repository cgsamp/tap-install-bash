#!/bin/bash
set -euo pipefail

tanzu package installed delete tap -n tap-install
kubectl delete namespace tap-install
