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

ros2_jazzy_env() {
  # ROS2 env-varibles
  source /opt/ros/${ROS_DISTRO}/setup.zsh
  export ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST
  export ROS_STATIC_PEERS=''
  export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
  export FASTDDS_DEFAULT_PROFILES_FILE=/opt/env/host/ros2/DEFAULT_FASTRTPS_PROFILES_FW.xml

  alias clbt='colcon build --packages-up-to $(basename `pwd`)'
  alias clb='colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'

  echo -e "Sourced ROS2-$ROS_DISTRO env"

  # source the user_workspace, if it exists
  # [ -e ~/user_ros_workspace/install/setup.zsh ] && source ~/user_ros_workspace/install/setup.zsh
  # [ -e ~/user_ros_workspace/src/mrs_ros2_ws/install/setup.zsh ] && source ~/user_ros_workspace/src/mrs_ros2_ws/install/setup.zsh
}

ros1_noetic_env() {
  # ROS2 env-varibles
  source /opt/ros/${ROS_DISTRO}/setup.zsh

  alias clbt='catkin bt'
  alias clb='catkin build'

  echo -e "Sourced ROS2-$ROS_DISTRO env"

  # source the user_workspace, if it exists
  # [ -e ~/user_ros_workspace/devel/setup.zsh ] && source ~/user_ros_workspace/devel/setup.zsh
}

if [[ "$ROS_DISTRO" =~ "noetic" ]]; then
  ros1_noetic_env
fi
if [[ "$ROS_DISTRO" =~ "jazzy" ]]; then
  ros2_jazzy_env
fi


