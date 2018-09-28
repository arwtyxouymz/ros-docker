FROM ubuntu:16.04

LABEL maintainer "Ryutaro Matsumoto <taross0524.ss@gmail.com>"

RUN apt-get update && apt-get install -y \
    wget \
    git \
    software-properties-common \
    && /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 \
    && /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' \
    && wget http://packages.ros.org/ros.key -O - | apt-key add - \
    && apt-get update \
    && apt-get install -y \
    ros-kinetic-desktop-full \
    python-dev \
    python-pip \
    python-rosinstall \
    python-catkin-tools \
    jq \
    && rm -rf /var/lib/apt/lists/* \
    && rosdep init \
    && rosdep update \
    && /bin/bash -c 'echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc' \
    && mkdir -p /catkin_ws \
    && pip install compdb
