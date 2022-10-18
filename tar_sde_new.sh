dev=sdg
dir=/home/ipfsbit/$dev/src-2
ls -l  $dir  |awk '{print $5}' >~/${dev}_1.txt
ls -l  $dir  |awk '{print $9}' >~/${dev}_2.txt

tar_and_trans(){
        line=`head -n1 ~/${dev}_1.txt`
        sed -i "1d" ~/${dev}_1.txt
        let size+=line
        let i+=1
        echo $i
        echo $size
        if [ $size -gt $standard_size ]
        then
                echo "size   大于  standard_size"
                random=`cat /proc/sys/kernel/random/uuid`
                name=`head -n $i ~/${dev}_2.txt |xargs`
                sed -i "1,${i}d" ~/${dev}_2.txt 
                cd $dir
                tar -cf ~/$random.tar $name
                echo "${random}.tar" >>~/${dev}_finish.txt
                mv ~/${random}.tar /storage-f0155049-14/real_data/cf/Sinso/
                size=0
                i=0
        fi
}


size=0
i=0
standard_size=18253611008
num=`cat ~/${dev}_1.txt |wc -l`
while  [ $num -gt 0 ]
do
        tar_and_trans
done
