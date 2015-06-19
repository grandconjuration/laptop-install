# Get name and email
echo "This script will setup your laptop"
echo ""
echo "Before we start we need some basic details of you"
echo ""
read -p "What is your full name? (e.g. Johny Appleseed): " full_name
read -p "What is your email address? (e.g. johny.appleseed@fabriquartz.com): " email_address
echo ""
echo "Hello $full_name <$email_address>"
echo ""
echo "Press any key to start the installation process, press <CTRL + C> to cancel"
read


echo "Installing Brew"
if ! command -v brew >/dev/null; then
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
fi

echo "Installing improved unix tools"
brew install wget
brew install coreutils
brew install moreutils
brew install findutils

brew install bash

brew tap homebrew/versions
brew install bash-completion2

brew install git
brew install vim
brew install the_silver_searcher

brew install openssl
brew unlink openssl && brew link openssl --force

echo "Installing Node.js"
brew install node

echo "Installing Brew Cask"
brew install caskroom/cask/brew-cask

echo "Installing Google Chrome"
brew cask install google-chrome
echo "Installing Sublime Text"
brew cask install sublime-text
echo "Installing Dash"
brew cask install dash
echo "Installing Alfred"
brew cask install alfred
echo "Installing Slack"
brew cask install slack
echo "Installing Harvest"
brew cask install harvest

brew cleanup

npm install npm -g; npm update -g

echo "Installing Bower"
npm install -g bower

echo "Installing PhantomJs"
npm install -g phantomjs

echo "Installing Ember CLI"
npm install -g ember-cli

echo "Creating folder ~/Project/Fabriquartz"
mkdir -pv ~/Projects/Fabriquartz

echo "Generating SSH key"
if [-e ~/.ssh/id_rsa ]
then
  echo "SSH key detected, skipping"
else
  ssh-keygen -q -t rsa -b 4096 -C "$email_address" -N "" -f ~/.ssh/id_rsa
fi

echo "Copying public key to clipboard, please add it to your Github account"
cat ~/.ssh/id_rsa | pbcopy

echo ""

echo "Setup up git config"
if [-e ~/.gitconfig ]
then
  echo "Gitconfig detected, skipping"
else
 cp gitconfig ~/.gitconfig

 git config --global user.name "$full_name"
 git config --global user.email "$email_address"
fi

echo "Setting up dotfiles"
if [-e ~/.bash_profile ]
then
  echo "Bash Profile detected, backing up"
  mv ~/.bash_profile ~/.bash_profile.backup
fi
cp aliases ~/.aliases

if [-e ~/.aliases ]
then
  echo "Aliases detected, skipping"
else
  cp aliases ~/.aliases
fi

if [-e ~/.exports ]
then
  echo "Exports detected, skipping"
else
  cp exports ~/.exports
fi

if [-e ~/.editorconfig ]
then
  echo "editorconfig detected, skipping"
else
  cp editorconfig ~/.editorconfig
fi

echo "Installing the Ruby version manager"
if ! command -v rvm >/dev/null; then
  \curl -sSL https://get.rvm.io | bash -s stable --ruby
else
  rvm get stable
  rvm reload
fi

source ~/.rvm/scripts/rvm

sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
chsh -s /usr/local/bin/bash
exec $SHELL -l

echo "Aaaaand were done!"
