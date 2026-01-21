docker:
	docker-compose up -d nginx workspace
dw:
	docker compose exec --user=laradock workspace bash
down:
	docker compose down
