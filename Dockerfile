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

COPY files/xrandrloop.sh /opt/xrandrloop.sh
RUN chmod +x /opt/xrandrloop.sh

RUN mkdir -p /etc/systemd/system/getty@tty1.service.d
COPY files/override.conf /etc/systemd/system/getty@tty1.service.d/override.conf

COPY files/config /etc/i3/config
RUN echo $COMMAND' & while [[ -d /proc/$! ]]; do sleep 1; done; echo 2' > /opt/app.sh
RUN chmod +x /opt/app.sh
RUN echo 'exec --no-startup-id /opt/app.sh' >> /etc/i3/config

COPY files/.xinitrc /home/user/.xinitrc
COPY files/.bash_profile /home/user/.bash_profile

RUN apt install -y net-tools iproute2 inetutils-ping

# GUI fixes
RUN apt install -y git meson build-essential libwayland-dev \
    cmake pkg-config libgbm-dev libdrm-dev libpixman-1-dev \
    libx11-xcb-dev libxcb-composite0-dev libxkbcommon-dev libgtest-dev
RUN git clone https://chromium.googlesource.com/chromiumos/platform2
RUN cd platform2/vm_tools/sommelier && meson build && sudo ninja -C build install
RUN mkdir -p /opt/google/cros-containers/bin/
RUN ln -s /usr/bin/Xwayland /opt/google/cros-containers/bin/Xwayland
ENV XDG_RUNTIME_DIR=/tmp/wayland
# RUN echo "nameserver 1.1.1.1" > /etc/resolv.conf

COPY files/start_app.sh /opt/start_app.sh
RUN chmod a+x /opt/start_app.sh

COPY files/app.service /etc/systemd/system/app.service
COPY files/app.service /lib/systemd/system/app.service
RUN chmod 644 /etc/systemd/system/app.service
RUN systemctl enable app