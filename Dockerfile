#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
# Note this base image is based on debian
FROM ubuntu:14.04
MAINTAINER Rischan Mafurur<rischan@kartoza.com>

# Use local cached debs from host (saves your bandwidth!)
# Change ip below to that of your apt-cacher-ng host
# Or comment this line out if you do not with to use caching
# ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng


# This section taken on 2 July 2015 from
# https://docs.docker.com/examples/running_ssh_service/
# Sudo is needed by pycharm when it tries to pip install packages
RUN apt-get update && apt-get install -y \
	python3-dev \
	python3-pip \
	python3-setuptools \
	git-core \
	ca-certificates \
	ssh

RUN mkdir -p /root/.ssh
# add custom ssh config / keys to the root user
RUN mkdir -p /root/.ssh
# Fixes permission if needed
# RUN chmod 600 /root/.ssh/*

# Added github.com as known_hosts
RUN ssh-keyscan -p2200 github.com > /root/.ssh/known_hosts

WORKDIR /

RUN git clone https://github.com/xybu/onedrive-d-old.git onedrive
RUN cd onedrive \
	&& python3 setup.py install \
	&& python3 setup.py clean

RUN mkdir ~/.onedrive
RUN cp /onedrive/onedrive_d/res/default_ignore.ini ~/.onedrive/ignore_v2.ini

RUN touch /var/log/onedrive_d.log
RUN chown `whoami` /var/log/onedrive_d.log

RUN apt-get update && apt-get install -y openssh-server sudo
RUN mkdir /var/run/sshd
RUN echo 'root:docker' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# End of cut & paste section
# ADD bashrc /root/.bashrc


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
