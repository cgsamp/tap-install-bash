#!/bin/bash
#set -euxo pipefail

tanzu apps workload delete tanzu-java-web-app --yes
tanzu apps workload create tanzu-java-web-app --git-repo https://github.com/sample-accelerators/tanzu-java-web-app --git-branch main --type web --label app.kubernetes.io/part-of=tanzu-java-web-app --yes
tanzu apps workload tail tanzu-java-web-app --since 10m --timestamp
