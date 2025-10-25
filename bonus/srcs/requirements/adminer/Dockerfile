FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y &&\ 
    apt-get install wget -y


COPY ./conf/adminer-conf.sh /tmp/adminer-conf.sh


RUN chmod +x  /tmp/adminer-conf.sh

CMD ["/bin/bash", "-c", "/tmp/adminer-conf.sh"]