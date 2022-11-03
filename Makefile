tag=latest

helm-upgrade:
	helm upgrade djkube helm/djkube --install --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

docker-build:
	docker build -t yellowcap/djkube .
