# create tmp and log dirs
mkdir log tmp

#create local dbs, migrate
rake db:create:all
rake db:migrate

#rake db:test:load