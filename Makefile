
helm-upgrade:
	helm upgrade djkube helm/djkube --install --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

docker-build:
	docker build -t yellowcap/djkube .

helm-refresh:
	helm delete djkube
	helm upgrade djkube helm/djkube --install --set global.postgresql.auth.postgresPassword=${POSTGRES_PASSWORD}

lint:
	black .
	isort .
	flake8