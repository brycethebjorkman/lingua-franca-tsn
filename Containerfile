# run `podman build -t lingua-franca-tsn --no-cache --pull .` to keep everything on latest

# base on the latest lingua-franca container image
FROM lingua-franca:latest

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    clang \
    cmake \
    && apt-get clean

WORKDIR /usr/app

# remove the source code for the lingua-franca test projects to prevent the lfc tool from seeing them as conflicts
RUN rm -r lingua-franca/test

# copy the project files over to container
COPY ./ /usr/app

ENTRYPOINT bash

# start with `podman run -it --rm lingua-franca-tsn`
