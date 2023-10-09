#!/bin/bash

source ../env.sh

aws_access_key_id=$(grep aws_access_key_id ~/.aws/credentials | cut -f3 -d ' ')
aws_secret_access_key=$(grep aws_secret_access_key ~/.aws/credentials | cut -f3 -d ' ')

cat conf/spark-defaults.conf \
	| sed -e "s/spark.hadoop.fs.s3a.access.key.*/& $aws_access_key_id/" \
	| sed -e "s/spark.hadoop.fs.s3a.secret.key.*/& $aws_secret_access_key/" \
	> ${SPARK_HOME}/conf/spark-defaults.conf

cd ${SPARK_HOME}/jars
sudo wget -q https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.2/hadoop-aws-3.3.2.jar
sudo wget -q https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.1026/aws-java-sdk-bundle-1.11.1026.jar
