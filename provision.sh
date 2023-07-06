#!/bin/bash

sudo apt update -qq
sudo apt upgrade -y
sudo apt install -y curl git gnupg2

gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles

source "$HOME/.rvm/scripts/rvm"

RUBY_VERSION="3.2.2"

rvm install $RUBY_VERSION
rvm alias create default $RUBY_VERSION@global
rvm use $RUBY_VERSION@global
rvm rvmrc warning ignore allGemfiles
rvm cleanup all

gem install colorls

mkdir -p ~/.config/colorls

ln -sf ~/projects/_environment/configs/dark_colors.yaml ~/.config/colorls/dark_colors.yaml
ln -sf ~/projects/_environment/dotfiles/bash_aliases ~/.bash_aliases
ln -sf ~/projects/_environment/dotfiles/bashrc ~/.bashrc
ln -sf ~/projects/_environment/dotfiles/gitconfig ~/.gitconfig
