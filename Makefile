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
	--set global.ingress.enabled=true \
	--set global.service.type=LoadBalancer

helm-dry-run:
	helm install djkube helm/djkube --dry-run --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

docker-build:
	docker build -t yellowcap/djkube .

code-update: docker-build helm-reset

upgrade-dependencies:
	pip-compile -o requirements.txt pyproject.toml
	pip-compile --extra dev -o dev-requirements.txt pyproject.toml

install:
	pip install -r requirements.txt

dev-install:
	pip install -r dev-requirements.txt

lint:
	black .
	isort .
	flake8