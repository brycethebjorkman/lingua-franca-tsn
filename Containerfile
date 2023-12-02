# run `podman build -t lingua-franca-tsn --no-cache --pull .` to keep everything on latest

# base on the latest lingua-franca container image
FROM lingua-franca:latest AS lf

# based on the [omnettpp inet dockerfile](https://github.com/omnetpp/dockerfiles/blob/master/inet/Dockerfile)
FROM ghcr.io/omnetpp/omnetpp:u22.04-6.0 as base

# first stage - build inet
FROM base as builder
ARG VERSION=4.5.2
WORKDIR /root
RUN wget https://github.com/inet-framework/inet/releases/download/v$VERSION/inet-$VERSION-src.tgz \
         --referer=https://omnetpp.org/ -O inet-src.tgz --progress=dot:mega && \
         tar xf inet-src.tgz && rm inet-src.tgz
WORKDIR /root/omnetpp
RUN . ./setenv && cd ../inet4.5 && . ./setenv && \
    opp_featuretool enable NetworkEmulationSupport && \
    make makefiles && \
    make -j $(nproc) MODE=release && \
    rm -rf out

# second stage - copy only the final binaries (to get rid of the 'out' folder and reduce the image size)
FROM base
RUN mkdir -p /root/inet4.5
WORKDIR /root/inet4.5
COPY --from=builder /root/inet4.5/ .
ARG VERSION=4.5.2
ENV INET_VER=$VERSION
RUN echo 'PS1="inet-$INET_VER:\w\$ "' >> /root/.bashrc && \
    echo '[ -f "$HOME/omnetpp/setenv" ] && source "$HOME/omnetpp/setenv" -f' >> /root/.bashrc && \
    echo '[ -f "$HOME/inet4.5/setenv" ] && source "$HOME/inet4.5/setenv" -f' >> /root/.bashrc && \
    touch /root/.hushlogin

# copy lingua-franca artifacts over
COPY --from=lf /usr/app /usr/app

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    clang \
    cmake \
    && apt-get clean

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    && apt-get clean

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3 \
    && apt-get clean

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openjdk-17-jre \
    openjdk-17-jdk \
    && apt-get clean

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    vim \
    && apt-get clean

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    iproute2 \
    && apt-get clean

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openssh-client \
    openssh-server \
    && apt-get clean

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    socat \
    && apt-get clean

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wireshark \
    && apt-get clean

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    iptables \
    && apt-get clean

WORKDIR /usr/app

# to support distributed execution, [install the lingua-franca RTI](https://www.lf-lang.org/docs/handbook/distributed-execution?target=py#installation-of-the-rti)
RUN git clone https://github.com/lf-lang/reactor-c.git && \
    cd reactor-c/core/federated/RTI/ && \
    mkdir build && cd build && \
    cmake ../ && \
    make && \
    make install

# remove the source code for the lingua-franca test projects to prevent the lfc tool from seeing them as conflicts
RUN rm -r lingua-franca/test

# copy the project files over to container
COPY ./ /usr/app

ENV PATH="${PATH}:/usr/app/lingua-franca/build/install/lf-cli/bin"

ENTRYPOINT bash

# start with `podman run -it --rm lingua-franca-tsn`
