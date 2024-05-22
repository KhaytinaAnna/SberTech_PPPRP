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
cicd getter
kubectl apply -f ./getter/mounts.yaml



if ! command -v istioctl &> /dev/null; then
    chmod +x istio/install.sh; ./istio/install.sh
fi


kubectl apply -f ./istio/service-entry.yaml
if ! command -v minicube &> /dev/null; then
    kubectl apply -f ./istio/service.yaml
elif
    kubectl apply -f ./istio/gateway.yaml
fi