#!/bin/sh
##远程服务器调用脚本##
remotePath="/usr/locat/tomcat"
function close(){
	$group="";
	$project="";
	/bin/sh shellFile=${remotePath}/${group}/${project}/bin/shutdown.sh	
}
function start(){
	$group="";
	$project="";
	shellFile=${remotePath}/${group}/${project}/bin/startup.sh
	/bin/sh ${shellFile}
}
function unpackage(){

}