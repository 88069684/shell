#!/bin/sh
###迁移mongodb数据###
localHost=""
localPort=""
localDatabase=""
localAuthpasswd=""

descHost=""
descPort=""
descDatabase=""
descAuthpasswd=""

collections=("user" )
dataDir="./mongodata"


#1、导出数据
#2、导入数据