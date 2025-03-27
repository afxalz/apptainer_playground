#!/bin/bash

CUSTOM_LOCATION=/opt/env

# link bash and zsh rc files
[ ! -e ~/.zshrc ] && ln -s $CUSTOM_LOCATION/host/apptainer_config/apptainer_zshrc.sh ~/.zshrc
[ ! -d ~/.oh-my-zsh ] && ln -s /opt/oh-my-zsh ~/.oh-my-zsh

# [ ! -e ~/.vim ] && ln -s $CUSTOM_LOCATION/host/configs/dotvim ~/.vim

# [ ! -e ~/.vimrc ] && ln -s $CUSTOM_LOCATION/host/config/dotvimrc ~/.vimrc

# link tmux conf
[ ! -e ~/.tmux-themepack ] && ln -s $CUSTOM_LOCATION/host/config/dot_tmux-themepack ~/.tmux-themepack
[ ! -e ~/.tmux.conf ] && ln -s $CUSTOM_LOCATION/host/config/dot_tmux.conf ~/.tmux.conf

# touch ~/.sudo_as_admin_successful