.PHONY: dev prod health logs down pull-all

pull-all:
	cd ../backend && git fetch --tags && git checkout $(shell cd ../backend && git describe --tags --abbrev=0)
	cd ../frontend && git fetch --tags && git checkout $(shell cd ../frontend && git describe --tags --abbrev=0)

dev:
	docker compose up -d --build
	@echo "Dev stack started"

prod:
	docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
	@echo "Prod stack started"

health:
	@curl -sf http://localhost/api/health && echo " OK" || echo " FAIL"

logs:
	docker compose logs -f api

down:
	docker compose down
