#!/bin/bash

# aws ecr and docker login
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 590183962065.dkr.ecr.us-east-1.amazonaws.com

# Docker pull image
docker pull 590183962065.dkr.ecr.us-east-1.amazonaws.com/docker_project:$1

#delete the existing container
docker rm -f dotnet-app

# dokcer run the image
docker run -itd -p 8000:8000 --name dotnet-app 590183962065.dkr.ecr.us-east-1.amazonaws.com/docker_project:$1