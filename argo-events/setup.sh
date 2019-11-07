#!/bin/bash

# install argo
helm repo add argo https://argoproj.github.io/argo-helm
kubectl create namespace argo
helm install argo/argo --name argo --namespace argo

# install argo-events
kubectl create namespace argo-events
helm install argo/argo-events --name argo-events --namespace argo-events

# install sample webhook
kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/master/examples/event-sources/webhook.yaml
kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/master/examples/gateways/webhook.yaml
kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/master/examples/sensors/webhook.yaml
export WEBHOOK_SERVICE_URL=$(minikube service -n argo-events --url webhook-gateway-svc)
echo $WEBHOOK_SERVICE_URL
curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST $WEBHOOK_SERVICE_URL/example

# install prometheus
kubectl create namespace monitoring
helm install --name prometheus --namespace monitoring -f prometheus-values.yaml stable/prometheus
