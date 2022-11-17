helm-install:
	helm install djkube helm/djkube \
	--set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD} \
	--set global.redis.password=${REDIS_PASSWORD}

helm-upgrade:
	helm upgrade djkube helm/djkube

helm-reset:
	helm delete djkube
	make helm-install

helm-linode:
	helm upgrade djkube helm/djkube \
	--set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD} \
	--set global.redis.password=${REDIS_PASSWORD} \
	--set global.postgresql.storageClass="linode-block-storage" \
	--set global.ingress.enabled=true

helm-dry-run:
	helm install djkube helm/djkube --dry-run --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

docker-build:
	docker build -t yellowcap/djkube .

lint:
	black .
	isort .
	flake8