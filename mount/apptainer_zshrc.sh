export SHELL=$( which zsh )



# ROS2 env-varibles
source /opt/ros/humble/setup.zsh
export ROS_LOCALHOST_ONLY=1
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
export FASTDDS_DEFAULT_PROFILES_FILE=/opt/env/host/ros2/DEFAULT_FASTRTPS_PROFILES_FW.xml

alias clbt='colcon build --packages-up-to $(basename `pwd`)'
alias clb='colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'

# source the user_workspace, if it exists
[ -e ~/user_ros_workspace/install/setup.zsh ] && source ~/user_ros_workspace/install/setup.zsh

if [ -e /opt/env/host/config/dotzshrc ]; then

  source /opt/env/host/config/dotzshrc

fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
PROMPT='[Apptainer]'$PROMPT