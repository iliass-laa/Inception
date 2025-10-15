# FROM debian:bullseye

# RUN apt -y update && apt upgrade -y\
#     && apt install redis-server -y\
#     && systemctl start redis\
#     && systemctl enable redis

# ENTRYPOINT ["redis-cli"]

FROM debian:bullseye

RUN apt update && apt upgrade -y \
    && apt install -y redis-server \
    && rm -rf /var/lib/apt/lists/*

# Configure Redis to accept connections from other containers
RUN sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf

# Expose Redis port
EXPOSE 6379

# Run Redis in foreground (not as daemon)
CMD ["redis-server", "/etc/redis/redis.conf", "--daemonize", "no"]