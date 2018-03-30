FROM docker.elastic.co/logstash/logstash-oss:6.2.2

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

USER root
WORKDIR /root
RUN yum -y install wget zip unzip
RUN cd /usr/share/kibana/plugins && wget https://github.com/dlumbrer/kbn_network/releases/download/6.0.X-1/network_vis.zip
RUN cd /usr/share/kibana/plugins && unzip network_vis.zip
RUN cd /usr/share/kibana/plugins && rm -f network_vis.zip
RUN cd /root && wget https://github.com/nyurik/kibana-vega-vis/releases/download/v1.1.2/vega_vis-1.1.2--for-Kibana-6.1.4.zip
RUN unzip vega_vis-1.1.2--for-Kibana-6.1.4.zip
RUN sed -i 's/"version": "6.1.4"/"version": "6.2.2"/g' /root/kibana/vega_vis/package.json
RUN zip -r vega.zip /root/kibana
RUN /usr/share/kibana/bin/kibana-plugin install file:///root/vega.zip
RUN rm -f /root/vega_vis-1.1.2--for-Kibana-6.1.4.zip
RUN rm -f /root/vega.zip
RUN rm -rf /root/kibana
RUN yum -y remove wget zip unzip
RUN yum -y clean all
RUN rm -rf /var/cache/yum
USER kibana

STOPSIGNAL SIGTERM
