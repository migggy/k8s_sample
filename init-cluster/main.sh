#!/bin/bash

cd `dirname $0`

# create cluster for local pc
# TODO use config
# kind create cluster --name kind --config multi-node-cluster.yaml --image kindest/node:v1.15.0
kind create cluster --name kind --image kindest/node:v1.15.0
kubectl apply -f https://gist.githubusercontent.com/hjacobs/69b6844ba8442fcbc2007da316499eb4/raw/5b8678ac5e11d6be45aa98ca40d17da70dcb974f/kind-metrics-server.yaml

# setup helm2
# TODO support helm3
helm repo update
kubectl create serviceaccount -n kube-system tiller
kubectl create clusterrolebinding tiller-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl --namespace kube-system patch deploy tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
h
# install cluster component by helm
