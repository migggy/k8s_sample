#!/bin/bash

set -Ceu
cd "$(dirname "$0")"

# create cluster for local pc
kind create cluster --name kind --config multi-node-cluster.yaml --image kindest/node:v1.15.0
kubectl apply -f https://gist.githubusercontent.com/hjacobs/69b6844ba8442fcbc2007da316499eb4/raw/5b8678ac5e11d6be45aa98ca40d17da70dcb974f/kind-metrics-server.yaml

# setup helm
helm repo update
kubectl create serviceaccount -n kube-system tiller
kubectl create clusterrolebinding tiller-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --override spec.template.spec.serviceAccount="tiller"
until [ "$(kubectl get pods -n kube-system | grep tiller | awk '{print $2}')" = "1/1" ]; do
  sleep 1
done
