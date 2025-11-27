#!/bin/bash

# Variables
KAFKA_VERSION=3.8.1
BINARY_VERSION=2.13
IAM_AUTH_CLI_VERSION=2.2.0
export KAFKA_ROOT=$(pwd)/kafka_$BINARY_VERSION-$KAFKA_VERSION
export CLASSPATH="${KAFKA_ROOT}/libs/aws-msk-iam-auth-${IAM_AUTH_CLI_VERSION}-all.jar"

# Upgrade and add Java 11
sudo apt-get update -y
sudo apt-get updgrade -y
sudo apt-get install openjdk-11-jdk -y

# Download Kafka Binary
wget https://archive.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$BINARY_VERSION-$KAFKA_VERSION.tgz
tar -zxvf kafka_$BINARY_VERSION-$KAFKA_VERSION.tgz

cd kafka_$BINARY_VERSION-$KAFKA_VERSION
cd $KAFKA_ROOT/libs/

# Download AWS MSK IAM CLI
wget https://github.com/aws/aws-msk-iam-auth/releases/download/v$IAM_AUTH_CLI_VERSION/aws-msk-iam-auth-$IAM_AUTH_CLI_VERSION-all.jar
cd $KAFKA_ROOT/config

# AWS IAM Auth file
# https://github.com/aws/aws-msk-iam-auth
cat <<EOF> client.properties
security.protocol=SASL_SSL
sasl.mechanism=AWS_MSK_IAM
sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;
sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
EOF