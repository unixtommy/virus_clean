#!/bin/bash
service crond stop
 
busybox rm -f /etc/ld.so.preload
busybox rm -f /usr/local/lib/libcset.so
busybox rm -f /usr/local/lib/libpamcd.so
busybox rm -f /etc/ld.so.preload
busybox rm -f /usr/local/lib/libcset.so
busybox rm -f /usr/local/lib/libpamcd.so

 
# 清理异常进程
busybox ps -ef | busybox grep -v grep | busybox egrep 'ksoftirqds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'kthrotlds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'kpsmouseds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'kintegrityds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'khugepageds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'kerberods' && busybox awk '{print $1}' && busybox xargs kill -9
 
busybox rm -f /tmp/kerberods
busybox rm -f /tmp/kthrotlds
busybox rm -f /tmp/kintegrityds
busybox rm -f /tmp/khugepageds
busybox rm -f /tmp/kpsmouseds
busybox rm -f /etc/cron.d/tomcat
busybox rm -f /etc/cron.d/root
busybox rm -f /var/spool/cron/root
busybox rm -f /var/spool/cron/crontabs/root
busybox rm -f /etc/rc.d/init.d/kthrotlds
busybox rm -f /etc/rc.d/init.d/kerberods
busybox rm -f /etc/rc.d/init.d/kpsmouseds
busybox rm -f /etc/rc.d/init.d/kintegrityds
busybox rm -f /usr/sbin/kthrotlds
busybox rm -f /usr/sbin/kintegrityds
busybox rm -f /usr/sbin/kerberods
busybox rm -f /usr/sbin/kpsmouseds
busybox rm -f /tmp/ld.so.preload*
 
ldconfig
 
# 再次清理异常进程
busybox ps -ef | busybox grep -v grep | busybox egrep 'ksoftirqds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'kthrotlds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'kpsmouseds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'kintegrityds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'khugepageds' && busybox awk '{print $1}' && busybox xargs kill -9
busybox ps -ef | busybox grep -v grep | busybox egrep 'kerberods' && busybox awk '{print $1}' && busybox xargs kill -9

echo "please reboot"
# add new
# add qa branch test
# qa1