#!/bin/bash

helm install stable/jenkins --name jenkins -f jenkins.yaml
# add role to Agent
kubectl create clusterrolebinding jenkins --clusterrole cluster-admin --serviceaccount=default:default
