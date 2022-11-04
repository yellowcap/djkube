# DJKUBE
Django and Celery on Kubernetes Helm using PostgreSQL and Redis backends. This is not yet
a production ready setup but is following best practices wherever possible.

The django part of this setup needs to be dockerized. the[PostgreSQL](https://artifacthub.io/packages/helm/bitnami/postgresql) 
and [Redis](https://artifacthub.io/packages/helm/bitnami/redis) backends use the standard 
bitnami helm charts.

To use it locally, you need to build the django docker image and make sure your local
Kubernetes cluster can use it. For minkube this a two lines command (see below).

After building the image locally, the djkube helm chart can be installed normally using helm.

The Makefile gives hints on how to do it, but the following three commands should do the job
if minkube and helm are installed.

```sh
eval $(minikube docker-env)
export POSTGRES_PASSWORD=pgpass
export REDIS_PASSWORD=redispass
make docker-build
make helm-install
```

## Django setup
Dockerization of django is inspired by
https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/

The migration commands are run in a Init Container of the web deployment.

Staticfiles are served by django directly, which is not best practice but ok
for the purpose of this repository.

### Setup first django user
For setting up the first django user, run the create superuser command in one of
the web pods. Get its name and run something along the lines of

```sh
kubectl exec -it djkube-web-5785f5547b-b785p -- python manage.py createsuperuser
```
## Use local images in minikube
In development, the docker image for the django app can be built locally and
used directly without circling through a docker repository.

For minikube:
```sh
eval $(minikube docker-env)
make docker-build
```

See also
https://stackoverflow.com/questions/42564058/how-to-use-local-docker-images-with-minikube

## Improvements
- Make gunicorn and celery commands variables
- Check redis and postgres addresses are really the cluster head
- Readyness and liveness probes for celery: https://github.com/celery/celery/issues/4079
- Reduce config replication between web and workers