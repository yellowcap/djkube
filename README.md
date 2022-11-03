# DJKUBE

## Django setup

https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/

### Setup first django user
kubectl exec -it djkube-5785f5547b-b785p -- python manage.py createsuperuser

## Minikube use local image
https://stackoverflow.com/questions/42564058/how-to-use-local-docker-images-with-minikube

```sh
eval $(minikube docker-env)
make docker-build
```

## To Do
- Work with secrets for DB password
- Make gunicorn command a variable
- 