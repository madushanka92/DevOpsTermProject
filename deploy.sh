#!/bin/bash

# Ensure we're using the correct Docker context (for Minikube)
docker context use minikube

# Start Minikube if not running
echo "Starting Minikube..."
minikube start

# Explicitly set Docker environment for Minikube
eval $(minikube docker-env)

# Verify Docker is using Minikube's context
echo "Current Docker context:"
docker context show

# Pull the image from Docker Hub (update the image tag as needed)
echo "Pulling Docker image from Docker Hub..."
docker pull madushanka92/term-project:latest

# Verify that the image was pulled
echo "Docker image pulled:"
docker images | grep term-project

# Apply Kubernetes manifests
echo "Applying Kubernetes manifests..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Wait for deployment rollout
echo "Waiting for deployment rollout..."
kubectl rollout status deployment/term-project --timeout=5m

# Additional debugging
kubectl get deployments
kubectl get pods
kubectl describe deployment term-project