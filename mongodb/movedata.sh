#!/bin/sh
#####迁移mongodb数据#####
###迁移前的信息###
localHost="127.0.0.1"
localPort="27017"
localDatabase=""
localAuthpasswd=""
###迁移后的信息###
descHost=""
descPort="27017"
descDatabase=""
descAuthpasswd=""
###需要迁移的collection###
collections=("user" )
dataDir="./mongodata"
####1、导出数据####

####2、导入数据####