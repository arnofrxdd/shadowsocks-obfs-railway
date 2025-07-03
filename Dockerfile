FROM debian:bullseye

RUN apt update && apt install -y shadowsocks-libev simple-obfs

ENV SERVER_ADDR=0.0.0.0 \
    SERVER_PORT=${SERVER_PORT:-8388} \
    PASSWORD=${PASSWORD} \
    METHOD=${METHOD:-chacha20-ietf-poly1305} \
    OBFS=${OBFS:-http} \
    OBFS_DOMAIN=${OBFS_DOMAIN}

CMD ss-server \
    -s $SERVER_ADDR \
    -p $SERVER_PORT \
    -k $PASSWORD \
    -m $METHOD \
    --plugin obfs-server \
    --plugin-opts "obfs=$OBFS;obfs-host=$OBFS_DOMAIN"
