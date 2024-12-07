#!/bin/bash

# Ensure we're using the correct Docker context
docker context use minikube

# Start Minikube if not running
echo "Starting Minikube..."
minikube start

# Explicitly set Docker environment for Minikube
eval $(minikube docker-env)

# Verify Docker is using Minikube's context
echo "Current Docker context:"
docker context show

# Load the image into Minikube
echo "Loading term-project image into Minikube..."
docker image save term-project:latest | minikube image load -

# Verify image is loaded
echo "Images in Minikube:"
minikube image ls | grep term-project

# Apply Kubernetes manifests
echo "Applying Kubernetes manifests..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Wait for deployment
echo "Waiting for deployment rollout..."
kubectl rollout status deployment/term-project --timeout=5m

# Additional debugging
kubectl get deployments
kubectl get pods
kubectl describe deployment term-project