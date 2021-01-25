
#4096 41947135
#41947136 83890175
#83890176 125833215
#125833216 167776255
#167776256 209719295

#input: /dev/sdb 3 

dev='/dev/sdi'
num=3

python compute_part.py $dev $num > parted_data.txt

sgdisk -o $dev
cat parted_data.txt | while read start end
do
	echo "$start $end"
	parted -s $dev mkpart primary ${start}s ${end}s
done
