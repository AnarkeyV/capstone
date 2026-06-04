#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="staging"
STABLE_DEPLOYMENT="capstone-app-stable"
CANARY_DEPLOYMENT="capstone-app-canary"
SERVICE_NAME="capstone-canary-service"
CONTAINER_NAME="app"

STABLE_MANIFEST="kubernetes/canary/stable-deployment.yaml"
CANARY_MANIFEST="kubernetes/canary/canary-deployment.yaml"
SERVICE_MANIFEST="kubernetes/canary/service.yaml"

LOCAL_PORT="8080"
SERVICE_PORT="80"

HEALTH_URL="http://localhost:${LOCAL_PORT}/health"
HOME_URL="http://localhost:${LOCAL_PORT}/"
PRODUCT_URL="http://localhost:${LOCAL_PORT}/product/TSHIRT-001"
CART_URL="http://localhost:${LOCAL_PORT}/cart"

echo "Starting canary deployment validation..."

echo "Checking Kubernetes connection..."
kubectl get namespace "${NAMESPACE}" >/dev/null

echo "Applying stable deployment..."
kubectl apply -f "${STABLE_MANIFEST}"

echo "Applying canary deployment..."
kubectl apply -f "${CANARY_MANIFEST}"

echo "Applying canary service..."
kubectl apply -f "${SERVICE_MANIFEST}"

echo "Waiting for stable deployment rollout..."
kubectl rollout status deployment/"${STABLE_DEPLOYMENT}" -n "${NAMESPACE}" --timeout=180s

echo "Waiting for canary deployment rollout..."
kubectl rollout status deployment/"${CANARY_DEPLOYMENT}" -n "${NAMESPACE}" --timeout=180s

echo "Current staging pods:"
kubectl get pods -n "${NAMESPACE}" -l app=capstone-canary-demo

echo "Starting port-forward to test the ClusterIP service..."
kubectl port-forward -n "${NAMESPACE}" service/"${SERVICE_NAME}" "${LOCAL_PORT}:${SERVICE_PORT}" >/tmp/capstone-canary-port-forward.log 2>&1 &
PORT_FORWARD_PID=$!

cleanup() {
  echo "Cleaning up port-forward..."
  kill "${PORT_FORWARD_PID}" >/dev/null 2>&1 || true
}

trap cleanup EXIT

sleep 5

echo "Testing canary service health endpoint..."
curl -fsS "${HEALTH_URL}" >/dev/null

echo "Testing homepage..."
curl -fsS "${HOME_URL}" >/dev/null

echo "Testing product detail page..."
curl -fsS "${PRODUCT_URL}" >/dev/null

echo "Testing cart page..."
curl -fsS "${CART_URL}" >/dev/null

echo "All canary health checks passed."

CANARY_IMAGE="$(kubectl get deployment "${CANARY_DEPLOYMENT}" -n "${NAMESPACE}" -o jsonpath="{.spec.template.spec.containers[0].image}")"

echo "Canary image detected:"
echo "${CANARY_IMAGE}"

echo "Promoting canary image to stable deployment..."
kubectl set image deployment/"${STABLE_DEPLOYMENT}" "${CONTAINER_NAME}=${CANARY_IMAGE}" -n "${NAMESPACE}"

echo "Waiting for stable deployment promotion rollout..."
kubectl rollout status deployment/"${STABLE_DEPLOYMENT}" -n "${NAMESPACE}" --timeout=180s

echo "Removing canary deployment after successful promotion..."
kubectl delete deployment "${CANARY_DEPLOYMENT}" -n "${NAMESPACE}" --ignore-not-found=true

echo "Canary promotion completed successfully."
echo "Stable deployment is now running:"
kubectl get deployment "${STABLE_DEPLOYMENT}" -n "${NAMESPACE}"