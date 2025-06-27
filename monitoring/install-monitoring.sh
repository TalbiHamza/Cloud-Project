#!/bin/bash

set -e

NAMESPACE="monitoring"
RELEASE_NAME="prometheus"
SERVICE_MONITOR_FILE="service-monitor-falcosidekick.yaml"

echo "Creating namespace: $NAMESPACE"
kubectl create namespace $NAMESPACE || echo "Namespace $NAMESPACE already exists."

echo "Adding Prometheus Helm repo..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "Installing Prometheus kube-prometheus-stack..."
helm install $RELEASE_NAME prometheus-community/kube-prometheus-stack --namespace $NAMESPACE

echo "Applying ServiceMonitor from $SERVICE_MONITOR_FILE..."
kubectl apply -f $SERVICE_MONITOR_FILE

echo "Installation complete."

echo ""
echo "Next steps:"
echo "1. Verify pods: kubectl get pods -n $NAMESPACE"
echo "2. Get Grafana credentials:"
echo "   USER: \$(kubectl get secret -n $NAMESPACE ${RELEASE_NAME}-grafana -o=jsonpath='{.data.admin-user}' | base64 -d)"
echo "   PASS: \$(kubectl get secret -n $NAMESPACE ${RELEASE_NAME}-grafana -o=jsonpath='{.data.admin-password}' | base64 -d)"
echo "3. Access Prometheus: kubectl port-forward svc/${RELEASE_NAME}-kube-prometheus-prometheus -n $NAMESPACE 9090:9090"
echo "4. Access Grafana: kubectl port-forward svc/${RELEASE_NAME}-grafana -n $NAMESPACE 3000:80"
