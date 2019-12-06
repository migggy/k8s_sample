#!/bin/bash
# Need following operation.
# Intall helm(v3.0 >), kind(v0.6.1 >) and go(v1.13 >) in advance
# Add helm repo.
#   - helm repo add stable https://kubernetes-charts.storage.googleapis.com/

cd `dirname $0`

# create cluster for local pc
kind create cluster --name kind --config multi-node-cluster.yaml --image kindest/node:v1.15.0
kubectl cluster-info --context kind-kind

# install cluster component
helm repo update
