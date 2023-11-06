# run `podman build -t lingua-franca-tsn --no-cache --pull .` to keep everything on latest

# base on the latest lingua-franca container image
FROM lingua-franca:latest AS base

FROM docker.io/omnetpp/inet:o6.0-4.4.1

# copy lingua-franca artifacts over
COPY --from=base /usr/app /usr/app

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
