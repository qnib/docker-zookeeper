###### grafana images
FROM qnib/java7

VOLUME ["/tmp/zookeeper"]
ENV ZK_VER 3.4.6
RUN curl -fsL http://apache.mirror.digitalpacific.com.au/zookeeper/zookeeper-${ZK_VER}/zookeeper-${ZK_VER}.tar.gz | tar xzf - -C /opt && mv /opt/zookeeper-${ZK_VER} /opt/zookeeper
RUN yum install -y bc
ADD etc/supervisord.d/zookeeper.ini /etc/supervisord.d/zookeeper.ini
ADD opt/qnib/zookeeper/bin/*.sh /opt/qnib/zookeeper/bin/
ADD etc/consul.d/zookeeper.json /etc/consul.d/
ENV PATH=/opt/zookeeper/bin:${PATH}
