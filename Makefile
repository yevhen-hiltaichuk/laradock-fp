docker:
	docker-compose up -d nginx workspace postgres pdf-generator
dw:
	docker compose exec --user=laradock workspace bash
dw-pdf:
	docker compose exec pdf-generator bash
down:
	docker compose down
env:
	cp .env.example .env
