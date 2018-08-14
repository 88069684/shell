#!/bin/bash
##copy file and restart tomcat
#export JAVA_HOME=/usr/local/java/jdk1.8.0_111
source /etc/profile

group=$1
project=$2
branch=$3

if [ -z "$branch" ];then
        echo "Defalut branch : dev"
        branch="dev"
fi

git_path=/xs/git_project/${group}/${project}
echo ${git_path}
cd ${git_path} && git pull && git checkout ${branch} && git pull

case   "$1"   in
        springboot)
                echo ${group} ${project}
                ##打包springboot项目##
                mvn clean package -Dspring.profiles.active=pro
                ;;
        *)
                echo ${group} ${project}
                mvn clean install -Ponlinealiyun
                ;;
esac
exit;
