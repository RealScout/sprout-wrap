# This is not meant to be run as a script - currently just a placeholder for all
# manual steps that need to be taken to setup a new mac. (currently incomplete)

# Install XCode

# Install Java sdk and jre
# http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
# http://www.oracle.com/technetwork/java/javase/downloads/jre7-downloads-1880261.html

# Add an ssh deploy key for the workstation
ssh-keygen -t rsa -C "rs-XXXX@realscout.com"
ssh-add ~/.ssh/RealScoutV2_id_rsa
cat ~/.ssh/RealScoutV2_id_rsa.pub
# Copy this into the RealScout Repo Settings on github as RS-XXXX Workstation

# Install homebrew - http://brew.sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/versions
brew doctor

# Install things for nokogiri
brew install libxml2 libxslt
xcode-select --install

brew install rbenv ruby-build
rbenv install 2.0.0-p598 # for RealScoutV2
rbenv install 1.9.3-p551 # for sprout wrap
rbenv rehash


# Clone sprout wrap and run it
mkdir ~/workspace
cd ~/workspace
git clone https://github.com/RealScout/sprout-wrap.git
cd sprout-wrap/
rbenv local 1.9.3-p551
gem install bundler
rbenv rehash
bundle
bundle exec soloist



# start up elasticsearch
ln -sfv /usr/local/opt/elasticsearch090/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch090.plist

# Edit redis brew recipe to use 2.6
brew edit redis
# url "http://download.redis.io/releases/redis-2.6.17.tar.gz"
# sha1 "b5423e1c423d502074cbd0b21bd4e820409d2003"
brew install redis

# start up redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist

# Clone RealScoutV2
cd ~/workspace
git clone git@github.com:RealScout/RealScoutV2.git
cd RealScoutV2/
rbenv local 2.0.0-p598
gem install bundler
rbenv rehash
bundle

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
