#!/bin/bash

# Step 1: Start Minikube (if not already running)
echo "Starting Minikube..."
minikube start

# Step 2: Point Docker to Minikube's Docker daemon
echo "Configuring Docker to use Minikube's Docker environment..."
eval $(minikube -p minikube docker-env)

# Step 3: Load Jenkins-built image into Minikube
echo "Loading the Docker image into Minikube..."
minikube image load term-project

# Step 4: Apply Kubernetes manifests
echo "Applying Kubernetes manifests..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Step 5: Wait for deployment rollout
echo "Waiting for deployment rollout..."
kubectl rollout status deployment/term-project

# Step 6: Expose the application
echo "Accessing the application..."
minikube service term-project-service

echo "Deployment complete!"
