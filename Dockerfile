FROM docker.elastic.co/kibana/kibana-oss:6.2.4

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

USER root
WORKDIR /root
RUN yum -y install wget zip unzip
RUN cd /usr/share/kibana/plugins && wget https://github.com/dlumbrer/kbn_network/releases/download/6.0.X-1/network_vis.zip \
    && cd /usr/share/kibana/plugins && unzip network_vis.zip \
    && cd /usr/share/kibana/plugins && rm -f network_vis.zip \
    && wget https://github.com/nyurik/kibana-vega-vis/releases/download/v1.1.2/vega_vis-1.1.2--for-Kibana-6.1.4.zip \
    && unzip vega_vis-1.1.2--for-Kibana-6.1.4.zip \
    && sed -i 's/"version": "6.1.4"/"version": "6.2.4"/g' /root/kibana/vega_vis/package.json \
    && zip -r vega.zip /root/kibana \
    && /bin/bash /usr/share/kibana/bin/kibana-plugin install file:///root/vega.zip \
    && rm -f /root/vega_vis-1.1.2--for-Kibana-6.1.4.zip \
    && rm -f /root/vega.zip \
    && rm -rf /root/kibana
COPY ./entrypoint.sh /opt/
RUN chmod +x /opt/entrypoint.sh
USER kibana

STOPSIGNAL SIGTERM

CMD /bin/bash /opt/entrypoint.sh
