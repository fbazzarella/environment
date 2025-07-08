#!/bin/bash

sudo apt install -y curl gnupg2 libpq-dev

gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ignore-dotfiles
source "$HOME/.rvm/scripts/rvm"

RUBY_VERSION="3.4.4"
NVM_VERSION="0.40.3"
NPM_VERSION="11.4.2"

rvm install ruby-$RUBY_VERSION
rvm alias create default $RUBY_VERSION@global
rvm use $RUBY_VERSION@global
rvm rvmrc warning ignore allGemfiles
rvm cleanup all

gem update --system
gem install colorls rails

curl -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install --lts --default
npm install --global npm@$NPM_VERSION yarn vite
yarn config set "strict-ssl" false

mkdir -p ~/.config/colorls

ln -sf ~/projects/_environment/dark_colors.yaml ~/.config/colorls/dark_colors.yaml
ln -sf ~/projects/_environment/bash_aliases ~/.bash_aliases
ln -sf ~/projects/_environment/bashrc ~/.bashrc
ln -sf ~/projects/_environment/gitconfig ~/.gitconfig
