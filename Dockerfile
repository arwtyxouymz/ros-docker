FROM ubuntu:14.04

LABEL maintainer "Ryutaro Matsumoto <taross0524.ss@gmail.com>"

RUN apt-get update && apt-get install -y \
    wget \
    git \
    software-properties-common \
    && /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list' \
    && /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' \
    && wget http://packages.ros.org/ros.key -O - | apt-key add - \
    && apt-get update \
    && apt-get install -y \
    ros-indigo-desktop-full \
    python-dev \
    python-pip \
    python-rosinstall \
    python-catkin-tools \
    jq \
    && rm -rf /var/lib/apt/lists/* \
    && rosdep init \
    && rosdep update \
    && /bin/bash -c 'echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc' \
    && mkdir -p /catkin_ws \
    && pip install compdb


ADD build.sh build.sh
WORKDIR /catkin_ws
CMD ["bash", "/build.sh"]
