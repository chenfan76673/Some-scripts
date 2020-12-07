#!/usr/bin/python
#-*- coding: UTF-8 -*-
import os
import paramiko


def get_hosts:
    hosts=[]
    with open('/etc/hosts') as f:
        for line in f:
                if 'local' in line:
                        continue
                elif '#' in line:
                        continue
                hosts.append(line.split()[1])
    return hosts

ssh = paramiko.SSHClient()
policy = paramiko.AutoAddPolicy()