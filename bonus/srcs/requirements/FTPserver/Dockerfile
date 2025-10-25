FROM debian:bullseye

RUN apt update  -y && apt install vsftpd -y

COPY ./conf/FTP-conf.sh /tmp/FTP-conf.sh

RUN  chmod +x  /tmp/FTP-conf.sh

EXPOSE 21

ENTRYPOINT ["bash", "-c"]

CMD ["/tmp/FTP-conf.sh"]