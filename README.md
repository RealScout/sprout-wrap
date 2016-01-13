## Installation under El Capitan (OS X 10.11)

### 1. Install Command Line Tools
  
    xcode-select --install

If you receive a message about the update server being unavailable and are on Mavericks, then you already have the command line tools.

### 2. Setup github ssh key

```
mkdir -m 0744 ~/.ssh
```

Then put the appropriate private key into `~/.ssh/id_github_current`. Right now, this must be named exactly as so for ssh config and cloning RealScout repos to work properly.

* Copy RealScoutTech's key if using a pairing workstation OR
* Copy an existing github key OR
* [Generate a new key](https://help.github.com/articles/generating-ssh-keys/)

```
sudo chmod 0600 ~/.ssh/id_github_current
```

### 3. Clone this project

    git clone https://github.com/realscout/sprout-wrap.git
    cd sprout-wrap

### 4. Install soloist & and other required gems

If you're running under rvm or rbenv, you shouldn't preface the following commands with `sudo`.

    sudo gem install bundler
    bundle

#### !!Important!!

We need to remove the system bundler and its executables

    sudo gem uninstall bundler # Answer 'y' when asked if you want to remove executables

### 5. Run soloist

[The `caffeinate` command will keep your computer awake while installing; depending on your network connection, soloist can take from 10 minutes to 2 hours to complete.]

    caffeinate bundle exec soloist

When it fails

```
sudo chown `whoami` /Library/Caches/Homebrew/Casks/
```

Then run it again

    caffeinate bundle exec soloist

If it fails installing shiftit, just rerun it again

    caffeinate bundle exec soloist

### 6. Additional

#### Update `~/.bash_profile`

```
alias cdr='cd ~/workspace/RealscoutV2'
alias localip="ipconfig getifaddr en0"
alias be="bundle exec"
```

### 7. Start a new terminal session

It's very important to close out terminal and open a new session (preferably in iterm), so that your environment is setup correctly before configuring the RealScoutV2 app.

#### Install CCMenu

From the App Store - login in with tech+apple@realscout.com


## Look into

* BetterTouchTool
* BitBar (see #tech-news)
