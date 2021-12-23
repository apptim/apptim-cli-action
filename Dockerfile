FROM ubuntu:20.04

RUN apt-get -y update
RUN apt-get -y install curl unzip wget

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]