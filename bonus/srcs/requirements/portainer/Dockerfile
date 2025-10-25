FROM debian:bullseye


RUN apt -y update && apt upgrade -y\
    && apt install -y wget

COPY ./conf/portainer-conf.sh ./myConf.sh

RUN chmod +x myConf.sh

ENTRYPOINT ["/bin/bash","./myConf.sh"]