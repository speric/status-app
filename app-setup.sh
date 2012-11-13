#!/bin/bash

# create tmp and log dirs
mkdir log tmp

#install gems via Bundler
bundle install

#create local dbs, migrate
rake db:create:all
rake db:migrate
rake db:seed