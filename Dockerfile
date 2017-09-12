# Set base image
FROM centos:centos7

ENV container docker

RUN yum -y update
RUN yum clean all

RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs dbus fsck.ext4

RUN systemctl mask dev-mqueue.mount dev-hugepages.mount \
    systemd-remount-fs.service sys-kernel-config.mount \
    sys-kernel-debug.mount sys-fs-fuse-connections.mount \
    display-manager.service graphical.target systemd-logind.service

RUN yum -y install openssh-server 
RUN yum -y install openssh-clients
RUN yum -y install sudo

RUN sed -i 's/#PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN systemctl enable sshd.service

EXPOSE 22

CMD ["/usr/sbin/init"]
