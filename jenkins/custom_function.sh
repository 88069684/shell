#!/bin/bash
function sendWarToRemote(){
        remote_port=51212
        remote_user=jenkins
        currentTime=`date "+%Y%m%d_%H%M%S"`
        remote_path=/usr/local/tomcat/${group}/${project}
        local_war=/xs/git_project/${group}/${project}/target/${war_name}.war
        echo $local_war
        remote_war=${remote_path}/war/${war_name}${currentTime}.war
        #发送到远程服务器/usr/local/tomcat/${group}
        ssh ${remote_user}@${remote_ip} -p${remote_port} "/bin/sh ${remote_path}/bin/shutdown.sh" && sleep 2
        #ssh ${remote_user}@${remote_ip} -p${remote_port} "ps -ef | grep ${project}| grep -v "grep" |awk '{print $2}' | xargs kill -9 "
        echo "关闭成功"
        scp -P${remote_port} ${local_war} ${remote_user}@${remote_ip}:${remote_war}
        ssh ${remote_user}@${remote_ip} -p${remote_port} "rm -rf ${remote_path}/webapps/*"
        ssh ${remote_user}@${remote_ip} -p${remote_port} "unzip ${remote_war} -d ${remote_path}/webapps/${project}"
        ssh ${remote_user}@${remote_ip} -p${remote_port} "/bin/sh ${remote_path}/bin/startup.sh"
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