#/bin.bash

#Redis主从同步状态监控
#通过脚本去获取Redis 角色及Master连接状态信息。如有一项信息不正确时返回值0
#echo "1" 表示正常
#echo "0" 表示异常

PORT=6370
STATUS=`redis-cli -p $PORT info | grep -E "role" `
LINK_STATUS=`redis-cli -p $PORT info | grep -E "master_link_status"`
#将输出的结果再次输出
ROLE_STATUS=(`echo $STATUS`)
MASTER_LINK_STATUS=(`echo $LINK_STATUS`)
#通过输出进行判断
[[ ${ROLE_STATUS[0]} =~ "role:slave" ]]&& [[ ${MASTER_LINK_STATUS[0]} =~ "master_link_status:up" ]] && echo 1 || echo 0
