FROM easysoft/debian:11

LABEL maintainer "ysicing i@ysicing.me"

ENV OS_ARCH="amd64" \
    OS_NAME="debian-11" \
    HOME_PAGE="https://thekelleys.org.uk/dnsmasq/"

COPY debian/prebuildfs /

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

ARG IS_CHINA="true"
ENV MIRROR=${IS_CHINA}

RUN install_packages curl wget zip unzip s6 pwgen dnsmasq

# Install dnsmasq
ARG VERSION
ENV APP_VER=${VERSION}
ENV EASYSOFT_APP_NAME="dnsmasq $APP_VER"

RUN . /opt/easysoft/scripts/libcomponent.sh && q_download "0.4.0"

RUN echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq && \
    mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak

# Copy dnsmasq config files
COPY debian/rootfs /

EXPOSE 53 8080

VOLUME /data

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
