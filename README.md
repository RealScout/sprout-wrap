## Installation under El Capitan (OS X 10.11)

### 1. Install Command Line Tools
  
    xcode-select --install

If you receive a message about the update server being unavailable and are on Mavericks, then you already have the command line tools.

### 4. Setup github ssh key

```
mkdir ~/.ssh
```

Then put the appropriate private key into `~/.ssh/id_github_current`

* Copy RealScoutTech's key if using a pairing workstation OR
* Copy an existing github key OR
* [Generate a new key](https://help.github.com/articles/generating-ssh-keys/)

### 2. Clone this project

    git clone https://github.com/realscout/sprout-wrap.git
    cd sprout-wrap

### 3. Install soloist & and other required gems

If you're running under rvm or rbenv, you shouldn't preface the following commands with `sudo`.

    sudo gem install bundler
    bundle

### 4. Run soloist

[The `caffeinate` command will keep your computer awake while installing; depending on your network connection, soloist can take from 10 minutes to 2 hours to complete.]

    caffeinate bundle exec soloist



### New Mac Setup - DEPRECATED

#### Setup required before running soloist

``` bash
# Install XCode via apple app store

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
echo 'eval "$(rbenv init -)"' > ~/.bash_profile
source ~/.bash_profile
rbenv install 2.0.0-p598 # for RealScoutV2
rbenv install 1.9.3-p551 # for sprout wrap
rbenv rehash
```

#### Install this repo and run soloist

``` bash
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

#### Install brew recipes with edits

``` bash
# Edit redis brew recipe to use 2.6
brew edit redis
# url "http://download.redis.io/releases/redis-2.6.17.tar.gz"
# sha1 "b5423e1c423d502074cbd0b21bd4e820409d2003"
brew install redis

brew edit phantomjs
# replace entire contents of recipe with the contents of this url
# https://github.com/Homebrew/homebrew/blob/1a69283250d53c01fe018fa816cb523363de192b/Library/Formula/phantomjs.rb
brew uninstall phantomjs
brew install phantomjs

brew edit node
# replace entire contents of recipe with the contents of this url
# https://github.com/Homebrew/homebrew/blob/19336e4d9c0d9b6441f6eceb72d3580b7caa7ab8/Library/Formula/node.rb
brew uninstall node
brew install node
```

#### Install bower & gulp

``` bash
npm install -g bower gulp@3.8.10
```

#### Startup databases

``` bash

# start up elasticsearch
ln -sfv /usr/local/opt/elasticsearch090/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch090.plist

# start up redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist

```

#### Clone and setup RealScoutV2 app

``` bash

# Clone RealScoutV2
cd ~/workspace
git clone git@github.com:RealScout/RealScoutV2.git
cd RealScoutV2/
rbenv local 2.0.0-p598
gem install bundler
rbenv rehash
bundle

psql -c "create user realscout with superuser login password '123foo';"
cp config/database.sample.yml config/database.yml

# See /RealScoutV2/script/seed.sh for details on how to setup dev and test databases

./script/omnispec.sh
```
