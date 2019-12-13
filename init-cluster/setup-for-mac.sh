#!/bin/bash

cd `dirname $0`

# homebrew
brew install go \
             kind \
             derailed/k9s/k9s
             # helm3

# helm2
HELM_VERSION="v2.14.1"
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > tmp.sh
sh tmp.sh --version ${HELM_VERSION}
rm tmp.sh

# helm3
# helm repo add stable https://kubernetes-charts.storage.googleapis.com/
