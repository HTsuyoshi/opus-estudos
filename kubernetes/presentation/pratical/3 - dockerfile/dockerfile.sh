#!/bin/bash

# Remove images
docker image rm ubuntu_{sed,write}:1.0

# Dockerfile
# ubuntu_sed.Dockerfile
docker build -f ubuntu_sed.Dockerfile -t ubuntu_sed:1.0 .

# ubuntu_write.Dockerfile
docker build -f ubuntu_write.Dockerfile -t ubuntu_write:1.0 .
