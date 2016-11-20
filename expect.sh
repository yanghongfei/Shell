#首先需要检测系统有没有expect 
#!/usr/bin/expect -f
set f [open ./ip r]
while { [gets $f line ]>=0 } {
set ip [lindex $line 0]
set pwd [lindex $line 2]
spawn ssh -o StrictHostKeyChecking=no $ip
expect  "*password:" { send "$pwd\r" }
expect "#"
send "ifconfig \r"
send "iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 123 -j ACCEPT \r"
send "service iptables save \r"
send "yum install ntpdate -y \r"
send "/usr/sbin/ntpdate 0.cn.pool.ntp.org \r"
send "echo '*/10 * * * * sh /root/testdisk.sh' > /var/spool/cron/root \r"
send "echo '10 5 * * * /usr/sbin/ntpdate 0.cn.pool.ntp.org' >> /var/spool/cron/root \r"
send "exit\r"
interact
}
