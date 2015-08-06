###### grafana images
FROM qnib/java7

VOLUME ["/tmp/zookeeper"]
ENV ZK_VER 3.4.6
RUN curl -fsL http://apache.mirror.digitalpacific.com.au/zookeeper/zookeeper-${ZK_VER}/zookeeper-${ZK_VER}.tar.gz | tar xzf - -C /opt && mv /opt/zookeeper-${ZK_VER} /opt/zookeeper
ADD etc/supervisord.d/zookeeper.ini /etc/supervisord.d/zookeeper.ini
ADD opt/qnib/zookeeper/bin/start_zookeeper.sh /opt/qnib/zookeeper/bin/start_zookeeper.sh
ADD etc/consul.d/check_zookeeper.json /etc/consul.d/check_zookeeper.json
