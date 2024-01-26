#!/bin/bash

set -e  


sudo apt update 
sudo apt install curl lsb-release -y


sudo apt install locales -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8


ubuntu_version=$(lsb_release -rs)

if [ "$ubuntu_version" == "22.04" ]; then
    sudo apt install gnupg2 -y
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
    sudo apt update
    sudo apt install ros-hubble-ros-base
    echo "source /opt/ros/hubble/setup.bash" >> ~/.bashrc

    sudo apt install -y python3-colcon-common-extensions 


elif [ "$ubuntu_version" == "20.04" ]; then
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
    sudo apt update
    sudo apt install ros-noetic-ros-base
    echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

    sudo apt install -y python3-catkin-pkg python3-rospkg



elif [ "$ubuntu_version" == "18.04" ]; then
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
    sudo apt update
    sudo apt install ros-melodic-ros-base
    echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

    sudo apt install -y python3-catkin-pkg python3-rospkg
    
    

else
    echo "Error: Your Ubuntu version is not supported."
    exit 1
fi

source ~/.bashrc

sudo apt install -y build-essential cmake git libbullet-dev python3-flake8 python3-pip python3-pytest-cov python3-rosdep python3-setuptools python3-vcstool wget

sudo rosdep init
rosdep update


echo "ROS installed successfully. Please reboot your system now."

