#!/bin/bash
remotePort="51212"
remoteUser="jenkins"
localPath="/xs/git_project/"
remotePath="/usr/local/tomcat/"
remoteShell="/usr/local/tomcat/shell/"
function sendWarToRemote(){
        currentTime=`date "+%Y%m%d_%H%M%S"`
    	remote_path=${remotePath}${group}/${project}
    	local_war=${localPath}${group}/${project}/target/${war_name}.war
        echo $local_war
        remote_war=${remote_path}/war/${war_name}${currentTime}.war
        #发送到远程服务器/usr/local/tomcat/${group}
        ssh ${remoteUser}@${remote_ip} -p${remotePort} "/bin/sh ${remote_path}/bin/shutdown.sh" && sleep 2
        #ssh ${remoteUser}@${remote_ip} -p${remotePort} "ps -ef | grep ${project}| grep -v "grep" |awk '{print $2}' | xargs kill -9 "
        echo "关闭成功"
        scp -P${remotePort} ${local_war} ${remoteUser}@${remote_ip}:${remote_war}
        ssh ${remoteUser}@${remote_ip} -p${remotePort} "rm -rf ${remote_path}/webapps/*"
        ssh ${remoteUser}@${remote_ip} -p${remotePort} "unzip ${remote_war} -d ${remote_path}/webapps/${project}"
        ssh ${remoteUser}@${remote_ip} -p${remotePort} "/bin/sh ${remote_path}/bin/startup.sh"
}
function getWarName(){
    war=$project
    case   "$project" in
        server)
                war=tiantian-server
                ;;
    esac
    echo $war
}
function getRemoteIP(){

}
function remoteHuidu(){
        project=$1
        war_name=$2
        remote_ip=node4
        sendWarToRemote
}
function remote1(){
        project=$1
        war_name=$2
        remote_ip=node1
        sendWarToRemote
}
function remote2(){
        project=$1
        war_name=$2
        remote_ip=node2
        sendWarToRemote
}
function remote3(){
        project=$1
        war_name=$2
        remote_ip=node3
        sendWarToRemote
}
function remote4(){
        project=$1
        war_name=$2
        remote_ip=node4
        sendWarToRemote
}