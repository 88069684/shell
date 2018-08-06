#!/bin/bash
IP=`ifconfig|awk 'NR==2{print $2}'|awk -F: '{print $2}'`
MAIL="88069684@163.com"
#一.检查系统情况
#1.CPU检查
echo "##########CPU state show##########"
echo "_____________________________________________________________________________________________"
top -n 1|grep Cpu
us=`top -n 1|grep Cpu|awk '{print $2}'|awk -F"%" '{print $1}'`
us100=`echo "$us*100"|bc|awk -F"." '{print $1}'`
#echo us*100 = $us100
sy=`top -n 1|grep Cpu|awk '{print $3}'|awk -F"%" '{print $1}'`
sy100=`echo "$sy*100"|bc|awk -F"." '{print $1}'`
#echo sy*100 = $sy100
cpu_number=`echo "$us100+$sy100"|bc`
#echo us*100+sy*100 = $cpu_number
if [ $cpu_number -gt "7000" ];then
        echo "$IP CPU is hight" | mail -s "warn!server: $IP CPU is hight" $MAIL
else
    echo -e "\033[32m ...CPU is (OK) ! \033[0m"
fi
echo "_____________________________________________________________________________________________"
echo ""
#2.内存检查
echo "##########MEM state show##########"
echo "_____________________________________________________________________________________________"
free -m|awk 'NR<3{print}'
free -g |grep -i mem |awk '{if($4 < 10){ printf("3") > "/proc/sys/vm/drop_caches"}}';
echo -e "\033[32m ...内存 is (OK) ! \033[0m"
echo "_____________________________________________________________________________________________"
echo""
#3.硬盘空间检查
echo "##########DRIVE state show##########"
echo "_____________________________________________________________________________________________"
df -h
use_df=`df -h|awk 'NR==3{print $4}'`
if [ $use_df == "90%" ];then
    echo "$IP DF is hight" | mail -s "warn!server: $IP DF is hight" $MAIL
else
    echo -e "\033[32m ...硬盘 is (OK) ! \033[0m"
fi
if [ $use_df == "95%" ];then
    echo "$IP df is hight" | mail -s "warn!server: $IP DF is hight" $MAIL
else
    echo -e "\033[32m ...硬盘 is (OK) ! \033[0m"
fi
echo "_____________________________________________________________________________________________"
echo ""
#4.网络检查
echo "##########NETWORK state show##########"
ifconfig|awk -F":" 'NR==2 {print $2}'|awk 'BEGIN{print "IP"}{print $1}'
ifconfig|grep RX|awk 'NR==2{print}'
echo -e "\033[32m ...网络 is (OK) ! \033[0m"
echo "_____________________________________________________________________________________________"
echo ""
####################################################################################################
#二.检查nginx、php、mysql状态
#1.nginx ps and netstat
echo "##########nginx state show##########"
echo "_____________________________________________________________________________________________"
nginx_port_number=`netstat -lntp|grep :80|wc -l`   #1
nginx_process_number=`ps -ef|grep nginx|grep -v grep |wc -l`  #5
if [ $nginx_port_number == "0" ];then
    echo "$IP nginx is down" | mail -s "warn!server: $IP nginx_port is down" $MAIL
    /usr/local/nginx/sbin/nginx
    if [ $test_nginx != "0" ];then
        echo "$IP nginx is down" | mail -s "warn!server: $IP not't restart" $MAIL
    fi
else
    echo -e "\033[32m ...nginx is running(OK) ! $(date) \033[0m"
fi
if [ $nginx_process_number == "0" ];then
    echo "$IP nginx is down" | mail -s "warn!server: $IP nginx_process is down" $MAIL
    /usr/local/nginx/sbin/nginx
    test_nginx2=echo $?
    if [ $test_nginx2 != "0" ];then
        echo "$IP nginx is down" | mail -s "warn!server: $IP not't restart" $MAIL
    fi
else
    echo -e "\033[32m ...nginx is running(OK) ! $(date) \033[0m"
fi
echo "_____________________________________________________________________________________________"
echo ""
#2.php ps and netstat
echo "##########php state show##########"
echo "_____________________________________________________________________________________________"
php_fpm_port_number=`netstat -lntp|grep :9000|wc -l`  #1
php_fpm_process_number=`ps -ef|grep php-fpm|grep -v grep|wc -l`  #129
if [ $php_fpm_port_number == "0" ];then
    echo "$IP php-fpm is down" | mail -s "warn!server: $IP php_fpm_port is down" $MAIL
    /etc/init.d/php-fpm restart
    test_php1=echo $?
    if [ $test_php1 != "0" ];then
        echo "$IP php-fpm is down" | mail -s "warn!server: $IP not't restart" $MAIL
    fi
else
    echo -e "\033[32m ...PHP is running(OK) ! $(date) \033[0m"
fi
if [ $php_fpm_process_number == "0" ];then
    echo "$IP nginx is down" | mail -s "warn!server: $IP php_fpm_process is down" $MAIL
    /etc/init.d/php-fpm restart
    test_php2=echo $?
    if [ $test_php2 != "0" ];then
        echo "$IP php is down" | mail -s "warn!server: $IP not't restart" $MAIL
    fi
else
    echo -e "\033[32m ...PHP is running(OK) ! $(date) \033[0m"
fi
echo "_____________________________________________________________________________________________"
echo ""
#3.mysql ps and netstat

echo "##########mysql state show##########"
echo "_____________________________________________________________________________________________"
mysql_port_number=`netstat -lntp|grep :3306|wc -l`  #1
mysql_process_number=`ps -ef|grep mysql|grep -v grep|wc -l`  #2

if [ $mysql_port_number == "0" ];then
   echo "$IP mysql is down" | mail -s "warn!server: $IP mysql_port is down" $MAIL
   /etc/init.d/mysqld restart
   test_mysql1=echo $?
   if [ $test_mysql1 != "0" ];then
       echo "$IP mysql is down" | mail -s "warn!server: $IP not't restart" $MAIL
   fi
else
   echo -e "\033[32m ...MYSQL is running(OK) ! $(date) \033[0m"
fi

if [ $mysql_process_number == "0" ];then
        echo "$IP mysql is down" | mail -s "warn!server: $IP mysql_process is down" $MAIL
        /etc/init.d/mysqld restart
        test_mysql2=echo $?
        if [ $test_php2 != "0" ];then
                echo "$IP mysql is down" | mail -s "warn!server: $IP not't restart" $MAIL
        fi
else
   echo -e "\033[32m ...MYSQL is running(OK) ! $(date) \033[0m"
fi
echo "_____________________________________________________________________________________________"
