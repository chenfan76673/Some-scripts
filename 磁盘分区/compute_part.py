from sys import argv
import commands


#disk size G
returncode, out = commands.getstatusoutput("fdisk -s %s" % argv[1])
disk_size = int(out)/1024/1024
data_size= (disk_size-12*int(argv[2]))/int(argv[2])

s=4096
def compute():
    global s
    global data_size

    size = 10
    len = size*1024*1024*1024 / 512   #10G/sector

    print s, s + len -1
    s =  s + len
 
    size = 2

    len = size*1024*1024*1024 / 512   #2G/sector    
    print s, s + len -1
    s =  s + len


    size = data_size

    len = size*1024*1024*1024 / 512   #20G/sector    
    print s, s + len -1
    s =  s + len

#input:/dev/sdb num
if __name__ == '__main__':
   #script,num = argv
   for i in range(int(argv[2])):
      compute()
   
