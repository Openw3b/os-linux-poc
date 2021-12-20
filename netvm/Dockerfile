FROM alpine

RUN apk add dhclient openrc
RUN apk add util-linux
RUN passwd -d root ''

RUN echo 'agetty_options="--autologin root --noclear"' > /etc/conf.d/agetty-autologin
RUN rm -f /sbin/init && ln -s /sbin/openrc-init /sbin/init
RUN ln -s /etc/init.d/agetty /etc/init.d/agetty-autologin.ttyS0
RUN rc-update add agetty-autologin.ttyS0 default

RUN echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf
COPY files/iptables.rules /etc/iptables/rules-save
COPY files/init /init
RUN chmod +x /init

RUN rc-update add sysctl default
RUN rc-update add iptables default