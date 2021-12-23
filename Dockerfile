FROM python:3.8

WORKDIR /app

LABEL "com.github.actions.name"="apptim-cli-action"
LABEL "com.github.actions.description"="Run test in device farm"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"

LABEL version="0.0.1"
LABEL repository="https://github.com/apptim/apptim-cli-action"
LABEL homepage="https://apptim.com"
LABEL maintainer="Apptim Dev Team <support@apptim.com>"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION='1.18.14'

RUN pip3 install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

#ADD install-packages.sh /install-packages.sh
#RUN ./install-packages.sh
RUN apt-get update
RUN apt-get -y install curl unzip wget

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]