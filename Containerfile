# run `podman build -t lingua-franca-tsn --no-cache --pull .` to keep everything on latest

# base on the latest lingua-franca container image
FROM lingua-franca:latest

WORKDIR /usr/app

# copy the project files over to container
COPY ./ /usr/app

ENTRYPOINT bash

# start with `podman run -it --rm lingua-franca-tsn`
