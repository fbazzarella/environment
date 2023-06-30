#!/bin/bash

sudo apt update -qq
sudo apt upgrade -y
sudo apt install -y curl git gnupg2 libpq-dev postgresql-contrib

mkdir -p ~/.config/colorls
cp -f config/dark_colors.yaml ~/.config/colorls/dark_colors.yaml
ln -sf ~/projects/_environment/config/bash_aliases ~/.bash_aliases
cp -f config/bashrc ~/.bashrc
cp -f config/gitconfig ~/.gitconfig

gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles

source "$HOME/.rvm/scripts/rvm"

rvm install 3.2.0
rvm alias create default 3.2.0@global
rvm use 3.2.0@global
rvm rvmrc warning ignore allGemfiles
rvm cleanup all

gem install colorls

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.2/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install --lts --default
