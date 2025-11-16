#!/usr/bin/env bash
set -e

HOST="ec2-user@13.201.227.53"
KEY="C:/Users/janan/projects/demo-cicd-app/demo-key.pem"
IMAGE="yogasrisiva/demo-cicd-app:latest"

echo "=== Starting Deployment to EC2 ==="

ssh -o StrictHostKeyChecking=no -i "$KEY" $HOST << EOF
echo "Pulling latest Docker image..."
docker pull $IMAGE

echo "Stopping old container..."
docker stop demo-cicd-app || true
docker rm demo-cicd-app || true

echo "Starting new container on port 8081..."
docker run -d -p 8081:8081 --name demo-cicd-app $IMAGE

echo "Deployment complete!"
EOF
