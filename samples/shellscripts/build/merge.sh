#!/bin/bash

#SOURFILE="defconfig"
#DESTFILE="config-3.19.0-10-generic"
DESTFILE="config.old"
SOURFILE="config.new"
FILENAME=$SOURFILE

cp config.dbg config.dbg.bak
cp $DESTFILE config.dbg
#cp config.lxc.mini config.dbg

lines=0
addcnt=0
igncnt=0
while read LINE
do
	let lines=$lines+1
	last=$LINE
#	echo "$lines: "$LINE

	mainstr=$LINE
	substr=${mainstr%%=*}

	if [ ${#mainstr} -ne ${#substr} ]; then
		substr=$substr"="
		grep -q "$substr" config.dbg
		if [ $? -ne 0 ]; then
#			echo $LINE
			echo $LINE >> config.dbg
			let addcnt=$addcnt+1
		fi
	else
		let igncnt=$igncnt+1
	fi

if [[ $# -gt 0 && $lines -ge $1 ]]; then
#		echo "$lines: "$LINE
#		echo "#Justin.Zhao#$lines: "$LINE >> config.dbg
		break
fi
#
#	#cut sub string
#	substr=${mainstr:0:2}
#	#cut space string
#	substr=`echo $substr | sed s/[[:space:]]//g`
#
#	len=`expr length $substr`
#	if [ $len -eq 2 ]; then
#		#hex string to nubmer
#		((base="0x"$substr))
#
#		for ((i=0; i<16; i++))
#		do
#			let idx=4+i*3
#			offset=${mainstr:$idx:2}
#			offset=`echo $offset | sed s/[[:space:]]//g`
#			if [ "$offset" != "--" -a x"$offset" != x ]; then
#				let addr=base+i
#				#number to string
#				printf "0x%2x " $addr
#				#add your process
#			fi
#		done
#	fi
done  < $FILENAME

echo "$lines: "$last 
echo "Totally add $addcnt lines, ignore $igncnt lines!"
echo "#Justin.Zhao#$lines: "$last >> config.dbg

#cp config.dbg .config

echo ""
