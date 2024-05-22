#!/bin/bash

curl -L https://istio.io/downloadIstio | sh -
cd istio-1.22.0
export PATH=$PWD/bin:$PATH

echo 'y' | istioctl install --set profile=default --set values.global.proxy.privileged=true --set meshConfig.outboundTrafficPolicy.mode=ALLOW_ANY

kubectl label namespace default istio-injection=enabled
