# Petal Pokemon

## Description
Hands-on test for Ruby on Rails developer at PetalMD
## Config .env
rename .env_sample to .env
## Config the setup
```sh
docker-compose build
```
```sh
docker-compose up
```
## Enter container
```sh
docker exec -it petal_pokemon bash
```
## Create Database, migrate and populate database
after enter in container

command below will create, migrate and populate the data
```sh
./bin/initialize_setup.sh
```
## Run test, rubocop and generate swagger docs
```sh
bundle exec brakeman
bundle exec rspec
bundle exec rubocop
bundle exec rails rswag
```
## Run app
```sh
bundle exec rails s -b 0.0.0.0
```
## Features

Application http://localhost:3000
endpoint to login: [post] http://localhost:3000/authentications
with json params
```
{
    "authentication": {
        "email": "petal@petal.com",
        "password": "123456"
    }
}
```
### login example here (video)
[![Watch the video](https://www.hardware.com.br/static/wp/2019/10/05/80.jpg?fm=pjpg&ixlib=php-3.3.0)](https://youtu.be/DuLZV6o1FNA)


### for more endpoint information
Documentation http://localhost:3000/api-docs



