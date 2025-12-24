#!/bin/bash

ip_file=ip.txt
for i in `cat ${ip_file}`
do
        ipmi_ip=`mysql -uroot -p'235hdjs&$MN' -h 101.201.100.130  -e "select  IPMI  from tingyu_idc.cabinet_location where ip='$i' " |grep -v IP`
        if [ -z $ipmi_ip ]
        then
                echo $i err,不能通过BMC重启，因为没有BMC
                arr_err_restart+=($i)
        else
                arr+=(${ipmi_ip})
        fi
done

for i in "${arr[@]}"
do
        timeout 3  ipmitool -I lanplus -U admin -P admin -H $i -p 623 power off
done
sleep 3

for i in "${arr[@]}"
do
        timeout 3  ipmitool -I lanplus -U admin -P admin -H $i -p 623 power on |grep "Up/On"
        if [ $? -eq 0  ]
        then
                echo $i  重启成功
                arr_success_restart+=($i)
        else
                echo $i 重启失败
                arr_err_restart+=($i)
        fi
done

echo success_restart  ${arr_success_restart[@]}
echo err_restart  ${arr_err_restart[@]}
