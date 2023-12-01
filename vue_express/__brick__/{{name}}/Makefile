dev:
	docker compose -f docker-compose.yml up -d mysql
	docker compose -f docker-compose.yml up

migration:
	cd api && npx sequelize-cli migration:create --name $(name)

seed:
	cd api && npx sequelize-cli seed:generate --name $(name)

migrate:
	cd api && npx sequelize-cli db:migrate

init:
	cd api && npm install && npx sequelize-cli db:seed --seed 20231104224915-create-user-table.js && npx sequelize-cli db:seed --seed 20231104223852-create-admin-role-table.js
	curl -XPOST -H "Content-type: application/json" -d '{"email": "test@test.de", "password": "admin","role": "admin"}' 'http://localhost:3000/api/signup'