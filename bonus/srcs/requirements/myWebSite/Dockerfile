FROM debian:bullseye

RUN apt update -y && apt install -y curl
RUN apt install -y git
    # npm install -g yarn

COPY ./conf/mySite-conf.sh /tmp/mySite-conf.sh

RUN chmod +x  /tmp/mySite-conf.sh


# RUN yarn install

CMD ["/bin/bash", "-c", "/tmp/mySite-conf.sh"]