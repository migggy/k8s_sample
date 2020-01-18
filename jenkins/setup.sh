#!/bin/bash

set -Ceu
cd "$(dirname "$0")"

kubectl create namespace jenkins
helm install stable/jenkins --name jenkins --namespace jenkins -f jenkins.yaml
kubectl create clusterrolebinding jenkins --clusterrole cluster-admin --serviceaccount=jenkins:default
