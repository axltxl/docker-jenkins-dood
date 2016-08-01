# vim: ft=dockerfile
###############################################################################
# Jenkins with DooD (Docker outside of Docker)
# http://github.com/axltxl/docker-jenkins-dood
# Author: Alejandro Ricoveri <me@axltxl.xyz>
# Based on:
# * http://container-solutions.com/2015/03/running-docker-in-jenkins-in-docker
# * http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci
###############################################################################

FROM jenkins:2.7.1
MAINTAINER Alejandro Ricoveri <alejandroricoveri@gmail.com>

# Install necessary packages
USER root
RUN apt-get update \
      && apt-get install -y sudo supervisor \
      && rm -rf /var/lib/apt/lists/*

# Install docker-engine
# According to Petazzoni's article:
# ---------------------------------
# "Former versions of this post advised to bind-mount the docker binary from
# the host to the container. This is not reliable anymore, because the Docker
# Engine is no longer distributed as (almost) static libraries."
ARG docker_version=1.11.2
RUN curl -sSL https://get.docker.com/ | sh && \
    apt-get purge -y docker-engine && \
    apt-get install docker-engine=${docker_version}-0~jessie

# Make sure jenkins user has docker privileges
RUN usermod -aG docker jenkins

# Install initial plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# supervisord
USER root

# Create log folder for supervisor and jenkins
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /var/log/jenkins

# Copy the supervisor.conf file into Docker
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start supervisord when running the container
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
