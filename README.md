## How to run
```
docker-compose up
```
When docker-compose is ready, initialize db and load fake data:
```
docker-compose run web rake db:create db:migrate db:seed
```
Application is running at http://localhost:3000
