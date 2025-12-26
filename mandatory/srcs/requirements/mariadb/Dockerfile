FROM debian:bullseye

RUN apt -y update && apt upgrade -y

RUN apt -y install mariadb-server 


COPY ./tools/mdb-conf.sh /tmp/mdb-conf.sh


RUN chmod +x /tmp/mdb-conf.sh

EXPOSE 3306

ENTRYPOINT ["/bin/bash","/tmp/mdb-conf.sh"]

CMD ["mariadbd","--bind-address=0.0.0.0"]

