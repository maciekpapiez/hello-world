#!/bin/bash

set -e

REPOSITORY_URL=${REPO}
IMAGE_NAME="hello-world"
IMAGE_VERSION=${TRAVIS_COMMIT::7} # that's git rev-parse --short HEAD format

docker --version

echo "Installing aws-cli..."
pip install awscli --user
export PATH=~/.local/bin:$PATH

echo "Logging in to ECR..."
$(aws ecr get-login --no-include-email --region eu-west-1)

# echo "Building the image..."
# docker build . -f ./docker/k8s/Dockerfile -t $IMAGE_NAME

# echo "Tagging the image..."
# docker tag $IMAGE_NAME $REPOSITORY_URL/$IMAGE_NAME:$IMAGE_VERSION

echo "Pushing the image to the remote repository..."
docker push $REPOSITORY_URL/$IMAGE_NAME:$IMAGE_VERSION

echo "Done!"
