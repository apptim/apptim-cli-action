#!/bin/bash

 # Default to 1.11 if APPTIM_CLI_VERSION not set.
if [ -z "$APPTIM_CLI_VERSION" ]; then
	APPTIM_CLI_VERSION=1.11
fi

mkdir /tmp/apptim-cli
curl --output /tmp/apptim-cli/cli.zip https://devicefarm.apptim.com/apptim-cli-ubuntu-20.04-${APPTIM_CLI_VERSION}.zip
unzip /tmp/apptim-cli/cli.zip -d /tmp/apptim-cli

if [ -n "$APPTIM_AGENT_VERSION" ]; then
	/tmp/apptim-cli/apptim run --config ${CONFIG_PATH}  --agent-version ${APPTIM_AGENT_VERSION}
else
	/tmp/apptim-cli/apptim run --config ${CONFIG_PATH}
fi


