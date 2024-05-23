#!/bin/bash
USER=khaytinaanna
TOKEN=dckr_pat_fSzD2Ur86RFQJW36JJkGuOcXIHs
EMAIL=annakhaytina02@gmail.com

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



if [ -d "istio-1.22.0" ]; then
    echo ''
else
    chmod +x istio/install.sh; ./istio/install.sh
fi

echo 'y' | istioctl install --set profile=default --set values.global.proxy.privileged=true --set meshConfig.outboundTrafficPolicy.mode=ALLOW_ANY
kubectl label namespace default istio-injection=enabled
kubectl apply -f ./istio/service-entry.yaml
if ! command -v minicube &> /dev/null; then
    kubectl apply -f ./istio/service.yaml
else
    kubectl apply -f ./istio/gateway.yaml
fi