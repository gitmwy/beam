#!/bin/sh
TPID=`ps -ef|grep beam_admin|grep -v grep|awk '{print $2}'`
if [ '$TPID' == "" ];then
   echo "服务没有启动"
else
   kill -9 $TPID
fi
cd /home/appadmin/test/beam
sh start.sh start