#!/bin/sh
# tomcat-env.sh - starts a new shell with instance variables set
#. ./server.sh

DATE=`date +%Y%m%d%H%M%S`

## set tomcat base env
export TOMCAT_DIR=/home/tadaisy/server
export TOMCAT_HOME=$TOMCAT_DIR/apache-tomcat-8.5.9
#export SERVER_HOME=$TOMCAT_DIR/domains
export SERVER_HOME=$TOMCAT_DIR/tomcat
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TOMCAT_HOME/lib

export TOMCAT_USER=tadaisy
export SERVER_NAME=tomcat
export DOMAIN_IP=10.220.170.37

export LOG_DIR=/ap_log
export LOG_HOME=$LOG_DIR/$SERVER_NAME
#export JAVA_HOME=$TOMCAT_DIR/jdk1.7.0_67
export JAVA_HOME=/usr/java/jdk1.8.0_111

export PATH=$JAVA_HOME/bin:$TOMCAT_HOME/bin:$PATH

#export CATALINA_BASE=$SERVER_HOME/$SERVER_NAME
export CATALINA_BASE=$SERVER_HOME
export CATALINA_HOME=$TOMCAT_HOME
export CATALINA_OUT=$LOG_HOME/$SERVER_NAME/catalina.out


export PORT_SET=0
#export HTTP_PORT=$(expr $PORT_SET \* 100 + 8080)
#export AJP_PORT=$(expr $PORT_SET \* 100 + 8009)
#export HTTPS_PORT=$(expr $PORT_SET \* 100 + 8443)
#export SHUTDOWN_PORT=$(expr $PORT_SET \* 100 + 8005)
export HTTP_PORT=8080
export AJP_PORT=8009
export HTTPS_PORT=8443
export SHUTDOWN_PORT=8005

if [ "x$JAVA_OPTS" = "x" ]; then
   JAVA_OPTS="-server"
   JAVA_OPTS="$JAVA_OPTS -Dserver=$SERVER_NAME"
   JAVA_OPTS="$JAVA_OPTS -Dcatalina.base=$CATALINA_BASE"
   JAVA_OPTS="$JAVA_OPTS -Dcatalina.home=$CATALINA_HOME"
   JAVA_OPTS="$JAVA_OPTS -Dtomcat.server.name=$DOMAIN_IP"
   JAVA_OPTS="$JAVA_OPTS -Dtomcat.base.log=$LOG_HOME"
   JAVA_OPTS="$JAVA_OPTS -Dtomcat.startup.port=$HTTP_PORT"
   JAVA_OPTS="$JAVA_OPTS -Dtomcat.ajp.port=$AJP_PORT"
   JAVA_OPTS="$JAVA_OPTS -Dtomcat.shutdown.port=$SHUTDOWN_PORT"
   JAVA_OPTS="$JAVA_OPTS -Dtomcat.ssl.port=$HTTPS_PORT"
#   JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=euc-kr"
   JAVA_OPTS="$JAVA_OPTS -Dtomcat.jvmRoute=$SERVER_NAME"
   JAVA_OPTS="$JAVA_OPTS -Dtomcat.instance.dir=$TOMCAT_DIR/applications"

   JAVA_OPTS="$JAVA_OPTS -Xms2048m"
   JAVA_OPTS="$JAVA_OPTS -Xmx2048m"
   JAVA_OPTS="$JAVA_OPTS -XX:PermSize=256m"
   JAVA_OPTS="$JAVA_OPTS -XX:MaxPermSize=512m"
#   JAVA_OPTS="$JAVA_OPTS -Xss192k"

   JAVA_OPTS="$JAVA_OPTS -verbose:gc"
   JAVA_OPTS="$JAVA_OPTS -Xloggc:$LOG_HOME/gclog/gc.log.$DATE"
   JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDetails"
   JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCTimeStamps"
   JAVA_OPTS="$JAVA_OPTS -XX:+PrintHeapAtGC"
   JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError"
   JAVA_OPTS="$JAVA_OPTS -XX:HeapDumpPath=$LOG_HOME/gclog/$SERVER_NAME.$DATE.hprof"

   JAVA_OPTS="$JAVA_OPTS -Dorg.jboss.resolver.warning=true"
   JAVA_OPTS="$JAVA_OPTS -Djava.net.preferIPv4Stack=true"
   JAVA_OPTS="$JAVA_OPTS -Dsun.rmi.dgc.client.gcInterval=3600000"
   JAVA_OPTS="$JAVA_OPTS -Dsun.rmi.dgc.server.gcInterval=3600000"
   JAVA_OPTS="$JAVA_OPTS -Dsun.lang.ClassLoader.allowArraySyntax=true "

   JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote"
   JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.ssl=false"
   JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
   JAVA_OPTS="$JAVA_OPTS -Djava.rmi.server.hostname=10.217.77.19"
fi

export JAVA_OPTS

echo "================================================"
echo "TOMCAT_HOME=$TOMCAT_HOME"
echo "SERVER_HOME=$SERVER_HOME"
echo "SERVER_NAME=$SERVER_NAME"
echo "================================================"
