#/bin /bash
#descrition: testredis database 
#author: cfwl,crate date of 2014-06-06 
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SERVER=172.17.92.132
PORT=6379
export PATH
  
#operation redisdatabase
printf "\033[32mPlease Input One \'Key\' and \'Value\':\033[0m " key value
read key value
  
#create key 
redis-cli -h $SERVER -p $PORT set $key $value
printf "\n"
  
#To obtain key
redis-cli -h $SERVER -p $PORT get $key
printf "\n"
  
#Delete key
printf "\033[33mYour Miss Delete The key? \(y|n\):\033[0m  "
read str
while [[ $str != "y" ]]
        do
                printf "\033[33mYour MissDelete The key? \(y|n\):\033[0m  "
                read str
                [ $str = 'y' ] &&redis-cli -h $SERVER -p $PORT  DEL $key $value && printf "\n"
                [ $str = 'n' ] && exit 0
        done
  
#Judge key ifexists
#redis-cli -h $SERVER -p $PORT  EXISTS$key
