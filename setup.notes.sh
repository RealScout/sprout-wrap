# This is not meant to be run as a script - currently just a placeholder for all
# manual steps that need to be taken to setup a new mac. (currently incomplete)

cd workspace/
mv sprout-wrap pl-sprout-wrap
ssh-keygen -t rsa -C "pivotal-mansell@realscout.com"
mv ~/.ssh/id_rsa ~/.ssh/sprout-wrap-id
mv ~/.ssh/id_rsa.pub ~/.ssh/sprout-wrap-id.pub
cat ~/.ssh/sprout-wrap-id.pub  # and add as RealScout/sprout-wrap deploy key
git clone git@github.com:RealScout/sprout-wrap.git
ssh-keygen -t rsa -C "pivotal-mansell@realscout.com"
cat ~/.ssh/id_rsa.pub # and add as RealScout/RealScoutV2 deploy key
git clone git@github.com:RealScout/RealScoutV2.git

# http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
# http://www.oracle.com/technetwork/java/javase/downloads/jre7-downloads-1880261.html

#install homebrew
brew tap homebrew/versions

# Upgrade Xcode? bundle exec soloist will fail on nokogiri below without it

cd sprout-wrap
rbenv local 1.9.3-p448
gem install bundler
bundle && bundle exec soloist

cd RealScoutV2
rbenv install 1.9.3-p392
rbenv global 1.9.3-p392
gem install bundler
rbenv rehash
bundle

# start up elasticsearch
ln -sfv /usr/local/opt/elasticsearch090/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch090.plist

# start up redis
# note, make sure sprout-wrap has redis in it (preferably 2.6, not 2.8)
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist

psql -c "create user rails with superuser login password 'password';"
psql -c "create user realscout with superuser login password '123foo';"
psql -c "CREATE DATABASE rsv2_mls OWNER realscout;"

# edit config/database.yml

rake db:create
rake db:migrate
rake populate:import_rs_att_mappings
rake db:seed
rake elastic_search:index_agents
rake elastic_search:omniresults
rake test:prepare

rspec spec
