#!/bin/bash
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-np
minikube service prometheus-server-np

kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-np
minikube service grafana-np

echo "Password: $(kubectl get secret grafana-admin --namespace default -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 -d)"
