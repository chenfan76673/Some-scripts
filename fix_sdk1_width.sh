i=0 ; pat='^unit = ([0-9]+)$'
while true ; do
	unit=$(xfs_db -x -c "sb $i" -c "p unit" /dev/sdk1)
	[[ $unit =~ $pat ]] || break
	unit=${BASH_REMATCH[1]}
	xfs_db -x -c "sb $i" -c "write width $unit" /dev/sdk1
	i=$(($i+1))
done
