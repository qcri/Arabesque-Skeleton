#! /usr/bin/env sh

#hdfs dfs -rm -r Output

PROJECT_NAME="arabesque-skeleton"

JAR_DIR="`pwd`"
JAR=`find $ARABESQUE_JAR_DIR -maxdepth 1 -name "$PROJECT_NAME-*-jar-with-dependencies.jar" | head -1`

if [ -z "$JAR" ] ; then
  echo "No project jar found in $JAR_DIR. Did you compile it?"
  exit 66
fi

HADOOP_CP=".:${JAR}"

HADOOP_CLASSPATH=$HADOOP_CP hadoop jar $JAR io.arabesque.ArabesqueRunner -y $@
