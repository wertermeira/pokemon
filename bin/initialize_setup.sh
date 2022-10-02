#!/bin/bash
set -e

# create db and migrate
rails db:create db:migrate

# populate data base
rails populate:user
rails populate:kinds
rails populate:pokemons

exec "$@"