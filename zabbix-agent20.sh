#! /bin/bash
#####################################
#-----------------------------------#
#------zabbix_agentd2.0_install-----#
#-----------------------------------#
#####################################

user=zabbix
hostname=`hostname`
zabbix_path="/usr/local/zabbix_agent"
zabbix_name="zabbix_agents_2.0.6.linux2_6.amd64.tar.gz"
#zabbix_conf=`find /usr/local -name zabbix_agentd.conf`
#zabbix_conf_path=${zabbix_conf%/*}
#zabbix_sbin=`find /usr/local -name zabbix_agentd -type f`
#zabbix_sbin_path=${zabbix_sbin%/*}

#检查系统里面是否有yum安装的zabbix_agentd##
rpm -qa | grep zabbix >> /dev/null
 if [ $? == 0 ];then
            echo "zabbix_agentd is installed,If you need to continue the installation,Please execute 'yum remove zabbix-agent -y'"
            exit 110
 fi
#检查系统里面是否有编译安装的zabbix_agentd##
#find /usr/local -name zabbix_agentd.conf
zabbix_conf=`find /usr/local -name zabbix_agentd.conf`
zabbix_conf_path=${zabbix_conf%/*}
 if [ -f "$zabbix_conf" ];then
            echo "zabbi_agent2.0 installed exit 120"
            exit 120
  else  
            echo "install zabbix_agent"
 fi
 #检查是否存在Zabbix-agent安装包
 if [ -f "$zabbix_name" ];then
       echo "zabbix_agentd is exist"
  else
       echo  "wget zabbix-agent"
       yum install wget -y
       wget http://www.zabbix.com/downloads/2.0.6/zabbix_agents_2.0.6.linux2_6.amd64.tar.gz
       sleep 2
 fi
mkdir -p $zabbix_path
tar zxvf $zabbix_name -C $zabbix_path
sleep 2
zabbix_conf=`find /usr/local -name zabbix_agentd.conf`
zabbix_conf_path=${zabbix_conf%/*}
cd $zabbix_conf_path
sed -i 's/Server=127.0.0.1/Server=Server.hostname/g' ./zabbix_agentd.conf
sed -i 's/ServerActive=127.0.0.1/ ServerActive=Server.hostname/g' ./zabbix_agentd.conf
sed -i "s/Hostname=Zabbix server/Hostname=$hostname/g" ./zabbix_agentd.conf        ##变量需要双引号来调用#
cat /etc/passwd | grep $user >> /dev/null
if [ $? == 0 ];then
     echo "User exist" >> /dev/null
else
   useradd $user
fi
####启动zabbix_agentd####
zabbix_conf=`find /usr/local -name zabbix_agentd.conf`
zabbix_conf_path=${zabbix_conf%/*}
zabbix_sbin=`find /usr/local -name zabbix_agentd -type f`
zabbix_sbin_path=${zabbix_sbin%/*}
$zabbix_sbin_path/zabbix_agentd -c $zabbix_conf_path/zabbix_agentd.conf
echo "Please execute 'netstat -tunlp | grep zabbix'"
exit 120
