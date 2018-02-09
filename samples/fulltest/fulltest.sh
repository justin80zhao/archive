#!/bin/bash
#Author: Justin Zhao
#Date: 28/3/2015

lxcdir='/usr/bin/'
outfile='testresult.txt'
tmpfile='tempfile'

cmds=()
count=0
passed=0
failed=0
echo "lxc-test-* start..." | tee $outfile
for i in "${lxcdir}"/lxc-test-*;
do
	echo ">>>Start:"$i | tee -a $outfile
	#$i | tee -a $outfile; result=$?
	$i > $tmpfile 2>&1
	result=$? 
	cat $tmpfile | tee -a $outfile
	echo "***Result="$result | tee -a $outfile
	let count=count+1
	if [ "$result" = "0" ]; then
		let passed=passed+1
	else
		let failed=failed+1
		cmds[${#cmds[@]}]=$i
	fi	
done

echo "============================" | tee -a $outfile
echo "total="$count",passed:"$passed",failed:"$failed | tee -a $outfile

if [ $failed -ne 0 ]; then
	echo "failed commands list:" | tee -a $outfile
	for cmd in "${cmds[@]}";
	do
		echo $cmd | tee -a $outfile
	done
fi
rm -rf $tmpfile
