#!/bin/sh
shellpath=$(cd `dirname $0`; pwd)
source  ${shellpath}/mysql_conf.sh
###每天备份###
dateTime=`date +'%Y_%m_%d'`

for database in ${databases[@]}; do
	dirPath=${filePath}/${database}
	if [ ! -d ${dirPath} ];then
		mkdir -p ${dirPath}
	#else
	#	echo "文件夹已经存在"
	fi
	backFile=${dirPath}/${database}_${dateTime}.sql

	#mysqldump -h${host} -u${userName} -p${passWord} ${database} > ${backFile}
	echo $backFile
done
exit;