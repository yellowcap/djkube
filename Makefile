helm-install:
	helm install djkube helm/djkube \
	--set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD} \
	--set global.redis.auth.password=${REDIS_PASSWORD}

helm-upgrade:
	helm install djkube helm/djkube

helm-reset:
	helm delete djkube
	helm install djkube helm/djkube --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

helm-dry-run:
	helm install djkube helm/djkube --dry-run --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

docker-build:
	docker build -t yellowcap/djkube .

lint:
	black .
	isort .
	flake8