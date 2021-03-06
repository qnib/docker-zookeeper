###### grafana images
FROM qnib/java8

VOLUME ["/tmp/zookeeper"]
ENV ZK_VER 3.4.8
EXPOSE 2181

RUN dnf install -y nc \
 && curl -fsL http://apache.mirror.digitalpacific.com.au/zookeeper/zookeeper-${ZK_VER}/zookeeper-${ZK_VER}.tar.gz | tar xzf - -C /opt && mv /opt/zookeeper-${ZK_VER} /opt/zookeeper
ADD etc/supervisord.d/*.ini /etc/supervisord.d/
ADD opt/qnib/zookeeper/bin/*.sh /opt/qnib/zookeeper/bin/
ADD etc/consul.d/zookeeper.json /etc/consul.d/
ADD opt/zookeeper/conf/zoo.cfg /opt/zookeeper/conf/
ADD etc/consul-templates/zoo.cfg.ctmpl etc/consul-templates/zoo.myid.ctmpl /etc/consul-templates/
ENV PATH=/opt/zookeeper/bin:${PATH}
RUN echo "tail -f /var/log/supervisor/zookeeper.log" >> /root/.bash_history && \
    echo "cat /opt/zookeeper/conf/zoo.cfg" >> /root/.bash_history
