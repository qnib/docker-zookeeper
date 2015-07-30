# docker-zookeeper
[![](https://badge.imagelayers.io/qnib/zookeeper:latest.svg)](https://imagelayers.io/?images=qnib/zookeeper:latest 'Get your own badge on imagelayers.io')

Docker Image containing a zookeeper master

## Start little stack

Not that I am big into zookeeper (read I dunno really know what I am doing [yet]), but it works in standalone.
I will try to setup a cluster someday, but for now... :)

```
$ docker-compose up -d
Creating dockerzookeeper_consul_1...
Creating dockerzookeeper_zookeeper0_1...
$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS                    NAMES
1d38ba333f2f        qnib/zookeeper      "/bin/supervisord -n   58 seconds ago      Up 57 seconds       0.0.0.0:2181->2181/tcp   dockerzookeeper_zookeeper0_1
8a0d84f47427        qnib/consul         "/bin/supervisord -n   58 seconds ago      Up 57 seconds       0.0.0.0:8500->8500/tcp   dockerzookeeper_consul_1
$ echo stat|nc 192.168.99.100 2181
Zookeeper version: 3.4.6-1569965, built on 02/20/2014 09:09 GMT
Clients:
 /192.168.99.1:56154[0](queued=0,recved=1,sent=0)

Latency min/avg/max: 0/0/0
Received: 8
Sent: 7
Connections: 1
Outstanding: 0
Zxid: 0x0
Mode: standalone
Node count: 4
```

