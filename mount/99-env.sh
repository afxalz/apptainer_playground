#!/bin/bash

CUSTOM_LOCATION=/opt/env

# link bash and zsh rc files
[ ! -e ~/.zshrc ] && ln -s $CUSTOM_LOCATION/host/apptainer_zshrc.sh ~/.zshrc

# [ ! -e ~/.vim ] && ln -s $CUSTOM_LOCATION/host/configs/dotvim ~/.vim

# [ ! -e ~/.vimrc ] && ln -s $CUSTOM_LOCATION/host/config/dotvimrc ~/.vimrc

# link tmux conf
# [ ! -e ~/.tmux.conf ] && ln -s $CUSTOM_LOCATION/host/config/dottmux.conf ~/.tmux.conf
[ ! -d ~/.oh-my-zsh ] && ln -s /opt/oh-my-zsh ~/.oh-my-zsh

# touch ~/.sudo_as_admin_successful