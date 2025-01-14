export SHELL=$( which zsh )

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -e /opt/env/host/config/dotzshrc ]; then

  source /opt/env/host/config/dotzshrc

fi

# prefix the shell prompt with Apptainer
PROMPT='[Apptainer]'$PROMPT

# ROS2 env-varibles
source /opt/ros/humble/setup.zsh
export ROS_LOCALHOST_ONLY=1
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
export FASTDDS_DEFAULT_PROFILES_FILE=/opt/env/host/ros2/DEFAULT_FASTRTPS_PROFILES_FW.xml

alias clbt='colcon build --packages-up-to $(basename `pwd`)'
alias clb='colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'

# source the user_workspace, if it exists
[ -e ~/user_ros_workspace/install/setup.zsh ] && source ~/user_ros_workspace/install/setup.zsh
[ -e ~/user_ros_workspace/src/mrs_ros2_ws/install/setup.zsh ] && source ~/user_ros_workspace/src/mrs_ros2_ws/install/setup.zsh
