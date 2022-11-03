
helm-upgrade:
	helm upgrade djkube helm/djkube --install --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

helm-refresh:
	helm delete djkube
	helm upgrade djkube helm/djkube --install --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

helm-dry-run:
	helm install djkube helm/djkube --dry-run --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

docker-build:
	docker build -t yellowcap/djkube .

lint:
	black .
	isort .
	flake8