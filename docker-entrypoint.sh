#!/bin/bash
set -e

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8

mkdir -p /root/.aws/

if [ ! -z $AWS_ACCESS_KEY_ID ] && [ ! -z $AWS_SECRET_ACCESS_KEY ];
then
    cat &> /root/.aws/credentials << EOF
[default]
aws_access_key_id=$AWS_ACCESS_KEY_ID
aws_secret_access_key=$AWS_SECRET_ACCESS_KEY
EOF
fi

if [ -e "/access_key" ] && [ -e "/secret_key" ];
then
    #echo "Use files to create temporally credentials file"
    cat &> /root/.aws/credentials << EOF
[default]
aws_access_key_id=$(cat /access_key)
aws_secret_access_key=$(cat /secret_key)
EOF
fi

cat &> /root/.aws/config << EOF
[default]
region=$AWS_REGION
output=json
EOF


OUTPUT=$(aws $@)
rm /root/.aws/credentials /root/.aws/config

[[ -n $JQ_PATH ]] && OUTPUT=$(echo $OUTPUT | jq "$JQ_PATH")
[[ -n $TRIM_QUOTES ]] && OUTPUT=$(echo $OUTPUT | tr -d '"')

echo $OUTPUT

