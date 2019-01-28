#!/bin/bash
# description: app开机启动脚本

# 接收入参带.jar的待启动包名称
packageName="$2"

RETVAL=0
APP_NAME=${packageName%.*}
APP_NAME=${APP_NAME:15}
export JAVA_HOME=/usr/local/java/jdk1.8.0_111
export JRE_HOME=/usr/local/java/jdk1.8.0_111/jre

APP_DIR=/usr/local/tiantian_dubbo/${APP_NAME}
JAR_NAME=${packageName}
PID=$APP_NAME\.pid
# 自定义
logPath=/datalog/service/$APP_NAME/$server_name
# 运行环境------------------------------必须要指定
envName=prod

cd $APP_DIR
case "$1" in
        start)
                nohup $JRE_HOME/bin/java -Dfile.encoding=utf-8 -Xms512m -Xmx1024m -jar $APP_DIR/$JAR_NAME --spring.profiles.active=$envName --logging.path=$logPath $APP_DIR
/$JAR_NAME >$logPath/nohup.out  2>&1 &
                echo $! > $APP_DIR/$PID
                echo "start $APP_NAME success!"
                ;;
        stop)
                kill -9 `cat $APP_DIR/$PID`
                rm -rf $APP_DIR/$PID
                echo "begin stop $APP_NAME"
                sleep 5
                APP_PID=`ps -ef|grep $$APP_NAME|grep $APP_DIR|grep -v 'grep'|awk '{print $2}'`
                if [ "$APP_PID" == "" ]; 
                then
                        echo "stop $APP_NAME success !"
                else
                        echo "$APP_NAME process pid is:$APP_PID"
                        echo "begin kill $APP_NAME process, pid is:$APP_PID"
                        kill -9 $APP_PID
                        echo "stop $APP_NAME success!"
                fi
                ;;
        restart)
                echo "restarting $APP_NAME"
                $0 stop
                sleep 2
                $0 start
                ;;
        *)
                echo "start|restart|stop"
                ;;
esac
exit 0