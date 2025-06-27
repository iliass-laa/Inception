FROM debian:bullseye


RUN apt -y update && apt upgrade -y\
    apt install -y php-fpm \
    php-mysql \
    wget \
    unzip \
    curl \
    less \
    vim \
    mariadb-client \

RUN mkdir -p /myApp

# WORKDIR /myApp

COPY ./conf/wp-conf.sh . 

RUN chmod +x wp-conf.sh


EXPOSE 9000


ENTRYPOINT ["./wp-conf.sh"]