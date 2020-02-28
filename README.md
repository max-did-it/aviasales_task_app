[![Build Status](https://travis-ci.com/max-did-it/aviasales_task_app.svg?branch=master)](https://travis-ci.com/max-did-it/aviasales_task_app)
## Dependencies

* Docker
* Docker-compose

## Build

* cd into projects dir
* `docker-compose build`


## Prepare database 

* `docker-compose up` (don't break it)
* `docker exec app bundle exec rails db:setup`
* now you can break first command

## Run

* cd into projects dir
* make sure what tcp port - 8080 is free
* `docker-compose up -d`
