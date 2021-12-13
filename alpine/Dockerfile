FROM alpine

RUN apk add dhclient openrc util-linux
RUN apk add eudev xorg-server xterm xf86-input-libinput
RUN passwd -d root '' ## Maybe not needed?
RUN adduser user -D
RUN echo 'agetty_options="--autologin root --noclear"' > /etc/conf.d/agetty-autologin
RUN rm -f /sbin/init && ln -s /sbin/openrc-init /sbin/init
RUN ln -s /etc/init.d/agetty /etc/init.d/agetty-autologin.tty1 
RUN rc-update add agetty-autologin.tty1 default

# Install apps
RUN apk add firefox mesa-egl
RUN echo 'xinit /usr/bin/firefox' > /runapp && chmod +x /runapp

#To be run on first boot, then reboot and run /runapp and wait
#setup-udev
#hostname vm
