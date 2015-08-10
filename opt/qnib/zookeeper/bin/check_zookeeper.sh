#!/bin/bash

function set_zk_mode {
	if ! egrep "tags.*${1}" /etc/consul.d/zookeeper.json;then
        sed -i'' -e "s/tags\": .*/tags\": [\"${1}\"],/" /etc/consul.d/zookeeper.json
        echo "Change tag to ${1}; reload consul"
        consul reload
	fi
}

zk_stat=$(echo stat | nc 127.0.0.1 2181)
mode=$(echo "${zk_stat}" |grep Mode |awk -F\: '{print $2}')
if [ "X${mode}" == "" ];then
        echo "Checked status endpoint; couldn't find mode"
        echo "${zk_stat}"
        exit 2
else
    set_zk_mode $(echo ${mode})
    echo "${zk_stat}"
fi
