[7/8 1:24 PM] Tien Nguyen
helm install istio-ingress istio/gateway -f ip-external.yaml
Helm show values istio/gateway | nano -
minikube start --driver=none --kubernetes-version v1.23.8
