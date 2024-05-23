## Пререквизиты:
для работы скрипта необходимо выполнить следующие шаги:
- подставить переменныe в bash.sh 
```
USER=
TOKEN=
EMAIL=
```
- заменить в деплойментах (в ./back.yaml и ./getter.yaml), в image USER на вашего действительного github юзера
- зачистить предыдущие ресурсы. если выполнение на миникуб, то 
```
minikube delete
```

## запуск

находиться в корневой директории проекта (на уровне с этим README)
```
chmod +x ./bash.sh; ./bash.sh
```

## тесты

Для проверки подов и получения их имен:
```
kubectl get pods
```

Для проверки доступа к внешнему API из контейнера back, можно войти в контейнер и выполнить запрос с помощью команды curl:
```
kubectl exec -it <back-pod-name> -- curl http://worldtimeapi.org/api/timezone/Europe/Moscow
```

Чтобы проверить доступ к сервису back из контейнера getter, можно выполнить аналогичный запрос:
```
kubectl exec -it <getter-pod-name> -- curl http://back-service.default.svc.cluster.local:8000
kubectl exec -it <getter-pod-name> -- curl http://back-service.default.svc.cluster.local:8000/time
kubectl exec -it <getter-pod-name> -- curl http://back-service.default.svc.cluster.local:8000/statistics
```

Чтобы удостовериться, что контейнер getter корректно монтирует и использует PV и PVC, можно выполнить следующие шаги:
  Войти в контейнер и проверить наличие файла /app/data/statistics_log.txt
```
kubectl exec -it <getter-pod-name> -- cat /app/data/statistics_log.txt
```
Перезагрузить под и проверить, что файл сохранился:
```
kubectl delete pod <getter-pod-name>
```
После перезапуска пода снова проверьте наличие файла:
```
kubectl get pods
kubectl exec -it <new-getter-pod-name> -- cat /app/data/statistics_log.txt
```