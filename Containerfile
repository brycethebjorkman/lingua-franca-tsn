# run `podman build -t lingua-franca-tsn --no-cache --pull .` to keep everything on latest

# base on the latest lingua-franca container image
FROM lingua-franca:latest

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    clang \
    cmake \
    && apt-get clean

WORKDIR /usr/app

# copy the project files over to container
COPY ./ /usr/app

ENTRYPOINT bash

# start with `podman run -it --rm lingua-franca-tsn`
