#!/usr/bin/python
#-*- coding: UTF-8 -*-
import os
import paramiko
import ConfigParser

cf = ConfigParser.ConfigParser()

cf.read("/etc/zettakit/zettakit.conf")

zdserver =  cf.get("storage","mon_ips").split(",")
zdclient = cf.get("compute","compute").split(",")
hosts = cf.get("cluster","ips").split(",")

"""
def get_hosts():
    hosts=[]
    with open('/etc/hosts') as f:
	for line in f:
		if 'local' in line:
			continue
		elif '#' in line:
			continue
		hosts.append(line.split()[0])
    return hosts
hosts = get_hosts()
"""



ssh = paramiko.SSHClient()
policy = paramiko.AutoAddPolicy()
ssh.set_missing_host_key_policy(policy)

def ssh_conn(IP,command):
	ssh.connect(
		hostname = IP,
		port = 22,
		username = "root",
		password = "root@zetta"
		)
	stdin,stdout,stderr = ssh.exec_command(command)
	print( stdout.read())
	result = stdout.read()
	error = stderr.read()
	print(result)

command_1 = [ "mkdir /var/lib/zdaemon/bak","mv /var/lib/zdaemon/scripts/* /var/lib/zdaemon/bak"]
command_2 = [ "systemctl stop zdserver","systemctl disable zdserver"]
command_3 = [ "systemctl stop zdclient","systemctl disable zdclient"]

command_0 = ["ip a|grep 39","echo 11111","echo 22222","echo 33333"]


def exec_cmd(IP,command)
	for cmd in command:
		for ip in IP:
			ssh_conn(ip,cmd)

exec_cmd(hosts,command_1)
exex_cmd(zdserver,command_2)
exec_cmd(zdclient,command_3)

