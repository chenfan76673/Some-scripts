dev=sdg
dir=/home/ipfsbit/$dev/src-2
ls $dir |xargs -n 30 > ~/$dev.txt
cp  ~/$dev.txt  ~/$dev.txt.bak
tar_and_trans(){
        i=`head -n1 ~/$dev.txt`
        sed -i "1d" ~/$dev.txt
        cd $dir
        sudo tar -rf  ~/${random}.tar $i
        size=`du -s -BG  ~/${random}.tar |awk '{print $1}'|sed "s/G//"`
        if [ $size -gt 17 ]
        then
                echo "~/${random}.tar" >>~/${dev}_finish.txt
                mv ~/${random}.tar /storage-f0155049-14/real_data/cf/Sinso/
                random=`cat /proc/sys/kernel/random/uuid`
                touch ~/${random}.tar
        fi
}


num=`cat ~/$dev.txt |wc -l`
random=`cat /proc/sys/kernel/random/uuid`
touch ~/${random}.tar
while  [ $num -gt 0 ]
do
        tar_and_trans
done 
