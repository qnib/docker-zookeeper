#!/bin/bash

function set_zk_mode {
    mode=${1-standalone}
    if [ ${mode} == "standalone" ];then
        mode=leader
   fi
    if ! egrep "tags.*${mode}" /etc/consul.d/zookeeper.json;then
        sed -i'' -e "s/tags\": .*/tags\": [\"${mode}\"],/" /etc/consul.d/zookeeper.json
        echo "Change tag to ${mode}; reload consul"
        consul reload
    fi
}

## In case the zookeeper instance should not be started
# eg. in case kafka inherits from this image, but uses an external zookeeper
if [ "X${START_ZOOKEEPER}" == "xfalse" ];then
    echo "'START_ZOOKEEPER==false', therefore it's fine... exit 2"
    exit 2
fi

zk_stat=$(echo stat | nc 127.0.0.1 2181)
if [ $? -ne 0 ];then
    echo "No connection to localhost:2181"
    exit 2
fi
mode=$(echo "${zk_stat}" |grep Mode |awk -F\: '{print $2}')
if [ "X${mode}" == "" ];then
        echo "Checked status endpoint; couldn't find mode"
        echo "${zk_stat}"
        exit 2
else
    set_zk_mode $(echo ${mode})
    echo "${zk_stat}"
    exit 0
fi
