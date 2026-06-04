#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="staging"
CANARY_DEPLOYMENT="capstone-app-canary"

echo "Rolling back canary deployment..."

kubectl delete deployment "${CANARY_DEPLOYMENT}" -n "${NAMESPACE}" --ignore-not-found=true

echo "Canary deployment removed."
echo "Stable deployment remains active."

kubectl get deployments -n "${NAMESPACE}"
kubectl get pods -n "${NAMESPACE}"