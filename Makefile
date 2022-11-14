helm-install:
	helm install djkube helm/djkube \
	--set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD} \
	--set global.redis.password=${REDIS_PASSWORD}

helm-upgrade:
	helm upgrade djkube helm/djkube

helm-reset:
	helm delete djkube
	make helm-install

helm-dry-run:
	helm install djkube helm/djkube --dry-run --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

docker-build:
	docker build -t yellowcap/djkube .

lint:
	black .
	isort .
	flake8