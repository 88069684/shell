#!/bin/sh
shellpath=$(cd `dirname $0`; pwd)
source  ${shellpath}/mysql_conf.sh
###备份脚本###
dateTime=`date "+%Y%m%d"`
currTime=`date "+%Y%m%d_%H%M%S"`
backFile=${filePath}/${dateTime}/${database}_${dateTime}.sql


mysqldump -h${host} -u${userName} -p${passWord} ${database} > ${backFile}