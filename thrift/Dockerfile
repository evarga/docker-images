# This Dockerfile is used to build an image containing the Apache Thrift framework. This image may be used 
# to compile .thrift files. The idea is to extend the user's development environment with a Thrift 
# compiler without any need to alter the user's machine. The generated libraries may be copied back onto a host
# using the Docker's cp command.
FROM ubuntu:trusty
MAINTAINER Ervin Varga <ervin.varga@gmail.com>

# Make sure the package repository is up to date.
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade

# Set the Thrift version number for this image.
ENV THRIFT_VERSION 0.9.1

# Set some auxiliary env. variables for later steps.
ENV FILE_NAME thrift-$THRIFT_VERSION
ENV SRC_URL http://www.trieuvan.com/apache/thrift/$THRIFT_VERSION/$FILE_NAME.tar.gz

# Download the matching tarball from the remote site and unpack it inside the container.
ADD $SRC_URL $FILE_NAME.tar.gz
RUN tar zxf $FILE_NAME.tar.gz
RUN rm $FILE_NAME.tar.gz
RUN mv $FILE_NAME /usr/local

# Install all necessary dependencies needed by Thrift.
RUN apt-get install -y --force-yes libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl1.0.0/trusty libssl-dev/trusty libglib2.0-dev
RUN apt-get install -y make

# Install OpenJDK 7 (latest version of it) and Ant
RUN apt-get install -y --no-install-recommends openjdk-7-jdk
RUN apt-get install -y ant

# Mount the volume to be used as a primary source folder, where user's thrift IDL files are situated.
VOLUME /src/thrift

# Compile and install Thrift.
RUN cd /usr/local/$FILE_NAME && ./configure --without-tests && make && make install

# Make the thrift.sh as an entry point for this container.
COPY thrift.sh thrift.sh
RUN chmod +x thrift.sh
ENTRYPOINT ["./thrift.sh"]