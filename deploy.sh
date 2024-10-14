#!/bin/bash

# aws ecr and docker login
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 010438494499.dkr.ecr.us-east-1.amazonaws.com

# Docker pull image
docker pull 010438494499.dkr.ecr.us-east-1.amazonaws.com/sample_docker:$1

# dokcer run the image
docker run -itd -p 8000:8000 --name Jen-public 10438494499.dkr.ecr.us-east-1.amazonaws.com/sample_docker:$1
