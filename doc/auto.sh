#!/bin/sh

#基本参数
FILE=heart-api-0.0.1-SNAPSHOT.jar
JENKINS=/root/.jenkins/workspace/heart_test/heart-api/target
HEART=/home/appadmin/test/heart
TPID=`ps -ef|grep heart-api|grep -v grep|awk '{print $2}'`
TIME=`date +%Y%m%d%H%M%S`

#停止服务
if [ $TPID == "" ];then
   echo "服务没有启动"
else
   kill -9 $TPID
fi

#创建备份目录
if [ ! -d $HEART/backup ];then
	mkdir $HEART/backup
	echo "创建备份目录成功"
fi

#备份文件
mv $HEART/$FILE $HEART/backup/'heart'$TIME'_bak'.jar
echo "备份成功"

#进入jenkins工作空间并复制jar/war
cp $JENKINS/$FILE $HEART
echo "复制jenkins工作空间中jar/war成功"

#启动程序
$HEART/start.sh start