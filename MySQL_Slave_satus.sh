#! /bin/bash
##Mysql主从状态监控##
#echo "1" 表示状态正常
#echo "0" 表示状态异常

STATUS=`mysql -uzabbix -S /tmp/zmysql.sock -e 'show slave status \G;' | grep -E "Slave_IO_Running|Slave_SQL_Running" | awk '{print $2}' |  tr "\n" " "`
arr_status=(`echo $STATUS`)
[[ ${arr_status[0]} =~ "Yes" ]] && [[ ${arr_status[1]} =~ "Yes" ]] && echo 1 || echo 0
