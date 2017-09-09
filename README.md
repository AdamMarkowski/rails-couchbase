## How to run
Firstly initialize database and load fake data:
```
docker-compose run web rake db:create db:migrate db:seed
```
Then start the project:
```
docker-compose up
```
After 20 seconds application is running at http://localhost:3000
