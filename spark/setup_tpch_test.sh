#!/bin/bash

source ../env.sh

cat conf/spark-defaults.conf \
	| sed -e "s/spark.hadoop.fs.s3a.access.key.*/& $AWS_ACCESS_KEY/" \
	| sed -e "s/spark.hadoop.fs.s3a.secret.key.*/& $AWS_SECRET_KEY/" \
	> ${SPARK_HOME}/conf/spark-defaults.conf

cd ${SPARK_HOME}/jars
sudo wget -q https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.2/hadoop-aws-3.3.2.jar
sudo wget -q https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.1026/aws-java-sdk-bundle-1.11.1026.jar
