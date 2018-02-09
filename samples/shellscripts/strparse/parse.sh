#!/bin/bash

FILENAME=$1

while read LINE
do
	mainstr=$LINE
	echo ""

	#cut sub string
	substr=${mainstr:0:2}
	#cut space string
	substr=`echo $substr | sed s/[[:space:]]//g`

	len=`expr length $substr`
	if [ $len -eq 2 ]; then
		#hex string to nubmer
		((base="0x"$substr))

		for ((i=0; i<16; i++))
		do
			let idx=4+i*3
			offset=${mainstr:$idx:2}
			offset=`echo $offset | sed s/[[:space:]]//g`
			if [ "$offset" != "--" -a x"$offset" != x ]; then
				let addr=base+i
				#number to string
				printf "0x%2x " $addr
				#add your process
			fi
		done
	fi
done  < $FILENAME

echo ""
