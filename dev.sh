podman run \
    -it \
    --rm \
    --device /dev/net/tun:/dev/net/tun \
    --cap-add NET_ADMIN \
    lingua-franca-tsn
