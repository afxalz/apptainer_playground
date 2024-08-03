#!/bin/bash

CUSTOM_LOCATION=/opt/env

# link bash and zsh rc files
[ ! -e ~/.bashrc ] &&  ln -s $CUSTOM_LOCATION/host/apptainer_bashrc.sh ~/.bashrc
# [ ! -e ~/.zshrc ] && ln -s $CUSTOM_LOCATION/host/apptainer_zshrc.sh ~/.zshrc
# [ ! -e ~/.profile ] && ln -s $CUSTOM_LOCATION/host/apptainer_profile.sh ~/.profile

# touch ~/.sudo_as_admin_successful

export PS1="[Apptainer] ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
