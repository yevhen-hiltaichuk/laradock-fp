docker:
	docker-compose up -d nginx workspace postgres
dw:
	docker compose exec --user=laradock workspace bash
down:
	docker compose down
env:
	cp .env.example .env
