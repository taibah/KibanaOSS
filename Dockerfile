FROM docker.elastic.co/kibana/kibana-oss:6.3.0

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

USER root
WORKDIR /root
RUN yum -y install wget zip unzip
RUN cd /usr/share/kibana/plugins && wget https://github.com/dlumbrer/kbn_network/releases/download/6.0.X-1/network_vis.zip 
RUN cd /usr/share/kibana/plugins && unzip network_vis.zip
RUN cd /usr/share/kibana/plugins && rm -f network_vis.zip
RUN rm -rf /root/kibana
USER kibana

STOPSIGNAL SIGTERM
