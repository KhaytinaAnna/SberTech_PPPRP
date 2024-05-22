## к baсk можно обратиться:

- из другого пода неймспейса дефолт по 

```
http://back-service/time
```

- если запуск был через микуб:

```
export INGRESS_HOST=$(minikube ip)
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
http://$INGRESS_HOST:$INGRESS_PORT/time
```

- если запуск был в классическом кубе :

```
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
http://<node ip>:$INGRESS_PORT/time
```

## Пререквизиты:
для работы скрипта необходимо выполнить следующие шаги:
- подставить переменныe в bash.sh 
```
USER=
TOKEN=
EMAIL=
```
- заменить в деплойментах (в ./back.yaml и ./getter.yaml), в image USER на вашего действительного github юзера