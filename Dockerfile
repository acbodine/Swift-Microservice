# Defines steps to compose a Ubuntu based container image, that installs the
# specified version of Swift, and configures the Swift package.
# Reference: https://swift.org/download/#linux

# The ubuntu image you base off of needs to correlate with the SWIFT_OS and
# SWIFT_OS_DIR build arguments in the following section.
FROM ubuntu:16.04

# These are Docker build args which allow you to provide cmd line overrides
# when running a `$ docker build ..` for this microservice's container image.
# Reference: https://swift.org/download/#releases
ARG SWIFT_BUILD=swift-3.0.2-release
ARG SWIFT_SNAPSHOT=swift-3.0.2-RELEASE
ARG SWIFT_OS=ubuntu16.04
ARG SWIFT_OS_DIR=ubuntu1604

# Install system packages that are required by Swift.
RUN apt-get update \
 && apt-get install -y \
    clang \
    gcc-4.8 \
    git-core \
    libcurl3 \
    libcurl4-gnutls-dev \
    libicu-dev \
    libssl-dev \
    libxml2 \
    openssh-client \
    openssl \
    wget \
 && rm -rf /var/lib/apt/lists/*

# Fetch, verify, and unpack swift directly to /usr/bin for all users to share.
# TODO: Verify checksum of swift download
RUN wget -nv https://swift.org/builds/$SWIFT_BUILD/$SWIFT_OS_DIR/$SWIFT_SNAPSHOT/$SWIFT_SNAPSHOT-$SWIFT_OS.tar.gz \
 && tar xzvf $SWIFT_SNAPSHOT-$SWIFT_OS.tar.gz --strip-components 1 \
 && rm $SWIFT_SNAPSHOT-$SWIFT_OS.tar.gz

# This path is totally up to you, feel free to change it to wherever makes
# sense for your microservice.
WORKDIR /root/microservice

# Fetch dependencies prior to copying in the codebase to speed up build
# iterations. This way the container image can just build the changes,
# instead of downloading the dependencies everytime we make a change.
# NOTE: Of course if you update Package.swift a `$ docker build ..` will
# continue from here.
COPY Package.swift .
RUN swift package fetch

# Install all of the repo files that haven't been ignored by .dockerignore to
# the current working directory, then build our Swift package.
# NOTE: The steps from here until the end of this file are all that are run
# when you make iterations on your Swift microservice.
COPY . .
RUN swift build

# Declaring the ports the microservice requires here, will allow Docker to do
# some useful heavy lifting for you in terms of port mapping.
# We will default to well known http/https ports.
# NOTE: You are free to expose as many and whichever ports you want here.
EXPOSE 80
EXPOSE 443

# Declare the target that will be what Docker runs inside your container as
# PID 1 when someone does a `$ docker run ...` for this image.
ENTRYPOINT [".build/debug/Swift-Microservice"]

# Use the CMD directive to provide a list of default inline parameters you
# want to pass to your ENTRYPOINT in the case that the user doesn't provide
# any when doing a `$ docker run ..` for this image.
CMD []
