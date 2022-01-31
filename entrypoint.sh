#!/bin/bash

mkdir /tmp/apptim-cli
curl --output /tmp/apptim-cli/cli.zip https://devicefarm.apptim.com/apptim-devicefarm-ubuntu-20.04-${APPTIM_CLI_VERSION}.zip
unzip /tmp/apptim-cli/cli.zip -d /tmp/apptim-cli

/tmp/apptim-cli/devicefarm run --config ${CONFIG_PATH}
