#!/bin/bash

log_file="/var/log/centos6_check.log"
chown root:root /etc/passwd /etc/shadow /etc/group /etc/gshadow
chmod 0644 /etc/group
chmod 0644 /etc/passwd 
chmod 0400 /etc/shadow
chmod 0400 /etc/gshadow


sed -i "s/^#LogLevel INFO/LogLevel INFO/g" /etc/ssh/sshd_config 
sed -i "s/^#ClientAliveInterval.*/ClientAliveInterval 600/g" /etc/ssh/sshd_config
sed -i "s/^#ClientAliveCountMax.*/ClientAliveCountMax 2/g" /etc/ssh/sshd_config
sed -i "s/^#MaxAuthTries.*/MaxAuthTries 4/g" /etc/ssh/sshd_config
sed -i "s/^#PermitEmptyPasswords.*/PermitEmptyPasswords no/" /etc/ssh/sshd_config


sed -i "s/^PASS_MIN_DAYS.*/PASS_MIN_DAYS   7/" /etc/login.defs && chage --mindays 7 root
sed -i "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/" /etc/login.defs && chage --maxdays 90 root

