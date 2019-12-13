#!/bin/bash

cd `dirname $0`

# create cluster for local pc
kind create cluster --name kind --config multi-node-cluster.yaml --image kindest/node:v1.15.0
kubectl apply -f https://gist.githubusercontent.com/hjacobs/69b6844ba8442fcbc2007da316499eb4/raw/5b8678ac5e11d6be45aa98ca40d17da70dcb974f/kind-metrics-server.yaml

# install cluster component by helm
helm repo update
