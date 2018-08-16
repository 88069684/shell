#!/bin/sh
###备份脚本###
dateTime=`date "+%Y%m%d"`
currTime=`date "+%Y%m%d_%H%M%S"`
backFile=${filePath}/${dateTime}/${database}_${dateTime}.sql


mysqldump -h${host} -u${userName} -p${passWord} ${database} > ${backFile}