FROM ubuntu

RUN apt-get update && \
    apt-get install -y dhcpcd5 util-linux systemd systemd-sysv
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y xorg
RUN apt-get install -y spice-vdagent i3-wm
RUN apt-get install -y xterm sudo

RUN systemctl disable gdm

ARG PACKAGES='firefox mousepad'
ARG COMMAND=firefox

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y $PACKAGES

COPY files/init /init
RUN chmod +x /init

RUN apt-get install -y net-tools inetutils-ping iproute2
RUN apt-get install -y netplan.io nano

COPY files/netplan.yaml /etc/netplan/00-default.yaml
RUN systemctl disable dhcpcd

RUN useradd -s /bin/bash -d /home/user/ -m -G sudo user
RUN chown -R user:user /home/user

#COPY files/xrandrloop.sh /opt/xrandrloop.sh
#RUN chmod +x /opt/xrandrloop.sh

RUN mkdir -p /etc/systemd/system/getty@tty1.service.d
COPY files/override.conf /etc/systemd/system/getty@tty1.service.d/override.conf

COPY files/config /etc/i3/config

RUN echo $COMMAND > /opt/app.sh
RUN chmod +x /opt/app.sh
RUN echo 'exec --no-startup-id /opt/app.sh' >> /etc/i3/config

#COPY files/.xinitrc /home/user/.xinitrc
#COPY files/.bash_profile /home/user/.bash_profile

COPY files/app.service /etc/systemd/system/app.service
COPY files/app.service /lib/systemd/system/app.service
RUN chmod 644 /etc/systemd/system/app.service
RUN systemctl enable app
