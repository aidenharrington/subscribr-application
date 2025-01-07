#!/bin/bash

# Stop and remove any existing container with the same name
docker-compose down

# Build and run the containers in detached mode
docker-compose up --build -d

# Print the container logs
docker-compose logs -f
