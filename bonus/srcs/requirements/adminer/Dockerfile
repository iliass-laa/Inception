FROM debian:bullseye

# RUN apt -y update && apt upgrade -y

RUN apt update
# RUN apt install php php-mysql apache2 -y

COPY ./conf/adminer-conf.sh /tmp/adminer-conf.sh


RUN chmod +x  /tmp/adminer-conf.sh

# EXPOSE 8080

# ENTRYPOINT ["/bin/bash", "tail. "]
# ENTRYPOINT ["/bin/bash", "-c", "tail -f /dev/null"]
# CMD ["/bin/bash", "-c", "tail -f /dev/null"]