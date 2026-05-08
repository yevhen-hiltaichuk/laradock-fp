docker:
	docker-compose up -d nginx workspace workspace-fp_backend php-fpm-fp_backend postgres pdf-generator
dw:
	docker compose exec --user=laradock workspace bash
dw-fp:
	docker-compose exec --user=laradock workspace-fp_backend bash
dw-pdf:
	docker compose exec pdf-generator bash
down:
	docker compose down
env:
	cp .env.example .env
