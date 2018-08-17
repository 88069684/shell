#!/bin/sh
shellpath=$(cd `dirname $0`; pwd)
source  ${shellpath}/mysql_conf.sh
###每天备份###
dateTime=`date %Y_%m_%d`
backFile=${filePath}/${database}_${dateTime}.sql
mysqldump -h${host} -u${userName} -p${passWord} ${database} > ${backFile}