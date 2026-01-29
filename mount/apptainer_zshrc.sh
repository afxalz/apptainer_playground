#!/bin/bash

export SHELL=$(which zsh)

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

CONTAINER_ENV_HOST=/opt/env/host

if [ -e $CONTAINER_ENV_HOST/dot_config/dot_zshrc ]; then
    source $CONTAINER_ENV_HOST/dot_config/dot_zshrc
fi

ros2_env() {
    source /opt/ros/$ROS_DISTRO/setup.zsh

    # ROS2 env-varibles
    export ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST
    export ROS_STATIC_PEERS=''
    export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
    export FASTDDS_DEFAULT_PROFILES_FILE=$CONTAINER_ENV_HOST/apptainer_config/ros2/DEFAULT_FASTRTPS_PROFILES_FW.xml

    # colcon mixin add mrs file://$CONTAINER_ENV_HOST/apptainer_config/ros2/colcon/index.yaml >/dev/null
    # colcon mixin update mrs >/dev/null

    alias clbt='colcon build --packages-up-to $(basename `pwd`)'
    alias clb='colcon build'
    # source the user_workspace, if it exists
    [ -e ~/workspaces/mrs_ros2_ws/install/setup.zsh ] && source ~/workspaces/mrs_ros2_ws/install/setup.zsh
}

ros1_env() {
    source /opt/ros/$ROS_DISTRO/setup.zsh

    alias clbt='catkin bt'
    alias clb='catkin build'
    [ -z "$ROS_PORT" ] && export ROS_PORT=11311
    [ -z "$ROS_MASTER_URI" ] && export ROS_MASTER_URI=http://localhost:$ROS_PORT
    export ROS_WORKSPACES="$ROS_WORKSPACES ~/user_ros_workspace"

    # if host pc is not Ubuntu 20.04
    OS_INFO=$(cat /proc/version)
    if ! ([[ "$OS_INFO" == *"Ubuntu"* ]] && [[ "$OS_INFO" == *"20.04"* ]]); then
        export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
        [[ -f /usr/share/gazebo/setup.bash ]] && source /usr/share/gazebo/setup.bash
    fi

    # source the user_workspace, if it exists
    # ONLY USE ONE AT A TIME
    # [ -e ~/workspaces/indair_ws/devel/setup.zsh ] && source ~/workspaces/indair_ws/devel/setup.zsh
    # [ -e ~/workspaces/training_ws/devel/setup.zsh ] && source ~/workspaces/training_ws/devel/setup.zsh
    # [ -e ~/workspaces/testing_ws/devel/setup.zsh ] && source ~/workspaces/testing_ws/devel/setup.zsh
    # [ -e ~/workspaces/indair_ws/devel/setup.zsh ] && source ~/workspaces/indair_ws/devel/setup.zsh
    [ -f ~/workspaces/training_ws/devel/setup.zsh ] && source ~/workspaces/training_ws/devel/setup.zsh || echo "Sourcing training_ws failed"
    # [ -f ~/workspaces/testing_ws/devel/setup.bash ] && source ~/workspaces/testing_ws/devel/setup.bash || echo "Sourcing testing_ws failed"
    # [ -f ~/workspaces/manuel_ws/devel/setup.bash ] && source ~/workspaces/manuel_ws/devel/setup.bash || echo "Sourcing manuel_ws failed"
}

# Read ROS_DISTRO environment variable
ROS_DISTRO=${ROS_DISTRO:-"unknown"}

case $ROS_DISTRO in
"noetic")
    echo "Sourced ROS Noetic"
    # Noetic-specific commands here
    ros1_noetic_env
    ;;
"jazzy")
    ros2_jazzy_env
    echo "Sourced ROS 2 Jazzy"
    # Jazzy-specific commands here

    ;;
*)
    echo "Unknown or unset ROS_DISTRO: $ROS_DISTRO"
    exit 1
    ;;
esac

# prefix the shell prompt with Apptainer
if [[ -f $CONTAINER_ENV_HOST/dot_config/starship.toml ]]; then
    export STARSHIP_CONFIG=$CONTAINER_ENV_HOST/dot_config/starship.toml
    eval "$(starship init zsh)"
else
    PROMPT='[Apptainer]%1~ %# '
fi

# source the linux setup from within
if [ -f /opt/klaxalk/git/linux-setup/appconfig/zsh/dotzshrc ]; then

    source /opt/klaxalk/git/linux-setup/appconfig/zsh/dotzshrc

fi
