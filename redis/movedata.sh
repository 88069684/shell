#!/bin/sh
###迁移redis数据###
##迁移前的信息##
localHost="127.0.0.1"
localPort="6379"
localAuthpasswd=""
##迁移后的信息##
descHost=""
descPort=""
descAuthpasswd=""

dataDir="./redisdata"
#1、导出数据
#2、导入数据