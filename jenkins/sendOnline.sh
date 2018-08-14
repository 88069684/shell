#!/bin/bash
source /xs/shell/custom_function.sh
group=$1
project=$2
remote=$3
if [ -z "$project" ];then
        echo "project不能为空,示例 xxx.sh project group remote"
        exit
fi

if [ -z "$group" ];then
        echo "group不能为空,示例 xxx.sh project group remote"
        exit
fi
if [ -z "$remote" ];then
        echo "remote不能为空,示例 xxx.sh project group remote"
        exit
fi
war=`getWarName`
case   "$remote" in
        node1)
                remote1 ${project} ${war} ${remote}
                ;;
        node2)
                remote2 ${project} ${war} ${remote}
                ;;
        node3)
                remote3 ${project} ${war} ${remote}
                ;;
        huidu)
                remote4 ${project} ${war} ${remote}
                ;;
esac
echo "$@脚本执行完毕"