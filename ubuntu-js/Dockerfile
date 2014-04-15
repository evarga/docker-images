# This Dockerfile is used to build an image containing necessary JavaScript frameworks as well as
# Selenium Web driver for performing UI functional testing. Other Web related containers may use
# this image as a good starting point, though.
# 
# NOTE: the Selenium Web driver may be also used to automate any post install procedures
#       performed via a Web UI (for example, initial update of the Magnolia CMS before first use).

FROM ubuntu:latest
MAINTAINER Ervin Varga <ervin.varga@gmail.com>

# Make sure the package repository is up to date.
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install common stuff needed by the rest of this build file.
RUN apt-get -y install bzip2
RUN apt-get -y install software-properties-common
RUN apt-get -y install python-software-properties

# Install NodeJS, PhantomJS, Selenium Web Driver, Karma and Mocha.
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -y install nodejs
RUN npm -g install selenium-node-webdriver
RUN npm -g install karma
RUN npm -g install mocha
RUN npm -g install phantomjs