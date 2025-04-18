#!/bin/bash

CONTAINER_ENV_HOST=/opt/env/host

# link bash and zsh rc files
[[ -f $CONTAINER_ENV_HOST/apptainer_config/apptainer_zshrc.sh ]] && ln -sf $CONTAINER_ENV_HOST/apptainer_config/apptainer_zshrc.sh ~/.zshrc
[[ -d /opt/oh-my-zsh ]] && ln -sf /opt/oh-my-zsh ~/.oh-my-zsh

# link tmux conf
[[ -d $CONTAINER_ENV_HOST/host/dot_config/dot_tmux-themepack ]] && ln -sf $CONTAINER_ENV_HOST/host/dot_config/dot_tmux-themepack ~/.tmux-themepack
[[ -f $CONTAINER_ENV_HOST/host/dot_config/dot_tmux.conf ]] && ln -sf $CONTAINER_ENV_HOST/host/dot_config/dot_tmux.conf ~/.tmux.conf
# touch ~/.sudo_as_admin_successful