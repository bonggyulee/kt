#!/bin/sh
. ./env.sh

# ------------------------------------
PID=`ps -ef | grep java | grep "=$SERVER_NAME" | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
    echo "TOMCAT($SERVER_NAME) is already RUNNING..."
    exit;
fi
# ------------------------------------
UNAME=`id -u -n`
if [ e$UNAME != "e$TOMCAT_USER" ]
then
    echo "$TOMCAT_USER USER to start Tomcat SERVER - $SERVER_NAME..."
    exit;
fi
# ------------------------------------

if [ ! -d $LOG_HOME ]; then
    mkdir $LOG_HOME
fi
if [ ! -d $LOG_HOME/nohup ]; then
    mkdir $LOG_HOME/nohup
fi

if [ -f $LOG_HOME/nohup/$SERVER_NAME.out ]; then
    mv $LOG_HOME/nohup/$SERVER_NAME.out $LOG_HOME/nohup/$SERVER_NAME.$DATE
    #mv $LOG_HOME/catalina.out $LOG_HOME/nohup/$SERVER_NAME.out
fi

if [ ! -d $LOG_HOME/gclog ]; then
    mkdir $LOG_HOME/gclog
fi

if [ -f $LOG_HOME/gclog/gc.log ]; then
    mv $LOG_HOME/gclog/gc.log $LOG_HOME/gclog/gc.log.$DATE
fi

#nohup $TOMCAT_HOME/bin/startup.sh >> $LOG_HOME/nohup/$SERVER_NAME.out 2>&1 &
export CATALINA_OUT=$LOG_HOME/nohup/$SERVER_NAME.out
nohup $TOMCAT_HOME/bin/startup.sh >> /dev/null 2>&1 &


echo "Starting... $SERVER_NAME"
while [ ! -f $LOG_HOME/nohup/$SERVER_NAME.out ];
do
continue;
done
#if [ ! -f $LOG_HOME/nohup/$SERVER_NAME.out ]; then
#    sleep 1;
#fi
tail -f $LOG_HOME/nohup/$SERVER_NAME.out;
exit;

