#!/bin/bash

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set. Quitting."
  exit 1
fi

# Default to us-east-1 if AWS_REGION not set.
if [ -z "$AWS_REGION" ]; then
  AWS_REGION="us-east-1"
fi


# Create a dedicated profile for this action to avoid conflicts
# with past/future actions.
# https://github.com/jakejarvis/s3-sync-action/issues/1
aws configure --profile apptim-cli-action-profile <<-EOF > /dev/null 2>&1
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_REGION}
text
EOF

mkdir /tmp/apptim-cli
curl --output /tmp/apptim-cli/cli.zip https://devicefarm.apptim.com/apptim-devicefarm-ubuntu-20.04-1.7.3dev.zip
unzip /tmp/apptim-cli/cli.zip -d /tmp/apptim-cli

/tmp/apptim-cli/devicefarm run --config ${CONFIG_PATH}

# Clear out credentials after we're done.
# We need to re-run `aws configure` with bogus input instead of
# deleting ~/.aws in case there are other credentials living there.
# https://forums.aws.amazon.com/thread.jspa?threadID=148833
aws configure --profile apptim-cli-action-profile <<-EOF > /dev/null 2>&1
null
null
null
text
EOF