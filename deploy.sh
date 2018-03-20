#!/bin/bash
# Use this script for starting everything

echo "Stop and remove running containers"
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

# Build the webservice
docker build -t webservice .


Deploy webservice with the Dashboard
echo "Deploy the webservice with the dashboard"
docker run -d --name app_with_dashboard -p 9001:9001 -e dashboard=True webservice
echo "Wait until the webservice is successfully started"
python test.py http://localhost:9001/


# Deploy webservice without the Dashboard
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
echo "Deploy the webservice without the dashboard"
docker run -d --name app_without_dashboard -p 9002:9001 -e dashboard=False webservice
python test.py http://localhost:9002/

# Stop all containers
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)