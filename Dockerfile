# syntax=docker/dockerfile:1

FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/Sao_Paulo

RUN apt update -qq
RUN apt upgrade -y
RUN apt install -y curl git gnupg2 libpq-dev postgresql-contrib
RUN apt install -y tzdata locales locales-all sudo nano

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN addgroup --gid 1000 docker
# ATTENTION HERE! 'MHFHMfLFw0xpc' <=> '123qwe' just for local and development purposes!
RUN useradd -m -u 1000 -g docker -g sudo -p MHFHMfLFw0xpc -s /bin/bash docker
COPY ./config/sudoers /etc/sudoers
RUN chmod 755 /etc/sudoers

USER docker:docker
WORKDIR /home/docker

RUN mkdir -p .config/colorls
COPY ./config/dark_colors.yaml .config/colorls/dark_colors.yaml
COPY ./config/bash_aliases .bash_aliases
COPY ./config/bashrc .bashrc
COPY ./config/gitconfig .gitconfig
RUN sudo chown -R docker:docker .
RUN chmod 755 .config/colorls/dark_colors.yaml .bash_aliases .bashrc .gitconfig

RUN gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles
RUN .rvm/bin/rvm install 3.2.0
RUN .rvm/bin/rvm alias create default 3.2.0@global
RUN .rvm/bin/rvm rvmrc warning ignore allGemfiles
RUN .rvm/bin/rvm cleanup all
RUN bash --login -c "gem install colorls rails"

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.2/install.sh | bash
RUN bash --login -c "source .nvm/nvm.sh && nvm install --lts --default"

# docker run \
#   --name devenv --publish 3000:3000 --user 1000:1000 \
#   --volume /home/wsl/projects:/home/docker/projects \
#   --interactive --tty --rm ubuntu-ruby bash --login

# docker exec -i devenv bash --login
