FROM ubuntu:16.04
MAINTAINER Ordinary Experts, contact@ordinaryexperts.com

ENV LAST_UPDATE=2017-03-08

#####################################################################################
# Current version is aws-cli/1.10.53 Python/2.7.12
#####################################################################################

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata locales && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Set the timezone
RUN echo "America/Los_Angeles" | tee /etc/timezone && \
    ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Set the locale for UTF-8 support
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && \
    locale-gen && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# AWS CLI needs the PYTHONIOENCODING environment varialbe to handle UTF-8 correctly:
ENV PYTHONIOENCODING=UTF-8

# man and less are needed to view 'aws <command> help'
# ssh allows us to log in to new instances
# vim is useful to write shell scripts
# python* is needed to install aws cli using pip install

RUN apt-get install -y \
    less \
    git \
    man \
    ssh \
    python \
    python-pip \
    python-virtualenv \
    vim

RUN pip install awscli

# php drupal 8 dependencies
RUN apt-get install -y \
    php7.0 \
    sqlite3 \
    php7.0-mysql \
    php7.0-sqlite3 \
    php7.0-xml
