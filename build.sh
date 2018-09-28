#!/usr/bin/env bash

cd /catkin_ws

if [ -e /catkin_ws/build/compile_commands.json ]; then
    rm /catkin_ws/build/compile_commands.json
fi

catkin build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
jsons=`find /catkin_ws/build -name compile_commands.json`
jq -s '[.[][]]' $jsons > /catkin_ws/build/compile_commands.json

cd /catkin_ws/build

if [ -x "$(command -v compdb)" ]
then
    compdb list > ../src/compile_commands.json
else
    echo -e "\033[0;33mWarning: compdb is not installed\033[;0m" >&2
fi
