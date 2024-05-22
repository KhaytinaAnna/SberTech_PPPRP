#!/bin/bash
USER=
TOKEN=
EMAIL=

docker login -u $USER -p $TOKEN

kubectl create secret docker-registry docker-sec \
    --docker-server=docker.io \
    --docker-username=$USER \
    --docker-password=$TOKEN \
    --docker-email=$EMAIL

function cicd {
    component=$1
    cd $component
    docker build -t ${component}:latest .
    docker tag ${component}:latest ${USER}/${component}:latest
    docker push ${USER}/${component}:latest

    kubectl apply -f ./${component}.yaml
    cd ..
}

cicd back
kubectl apply -f ./getter/mounts.yaml
cicd getter


