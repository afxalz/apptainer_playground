export SHELL=$( which zsh )

PROMPT='[Apptainer]%1~ %# '

# ROS2 env-varibles
source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
export FASTDDS_DEFAULT_PROFILES_FILE=/opt/env/host/ros2/DEFAULT_FASTRTPS_PROFILES_FW.xml

alias clbt='colcon build --packages-up-to $(basename `pwd`)'
alias clb='colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'

# source the user_workspace, if it exists
[ -e ~/user_ros_workspace/install/setup.zsh ] && source ~/user_ros_workspace/install/setup.zsh

# source the linux setup from within
if [ -e /opt/env/host/custom_configs/zsh/dotzshrc ]; then

  source /opt/env/host/custom_configs/zsh/dotzshrc

fi
