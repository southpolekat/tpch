#!/bin/bash

source env.sh

cp conf/spark-defaults.conf $SPARK_HOME/conf/

cd $SPARK_HOME/jars
sudo wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.2/hadoop-aws-3.3.2.jar
sudo wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.1026/aws-java-sdk-bundle-1.11.1026.jar
