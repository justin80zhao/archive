#!/bin/bash

arp -n|awk '/^[1-9]/{print "sudo arp -d  " $1}'|bash
arp -n | grep "incomplete"|awk '{print "ping -c 1 " $1}'|bash
echo ""
echo "============================================"
echo "===============Check Result================="
echo "============================================"
echo "Duplicate MAC address:"
arp -n|grep "ether"|awk '{print $3}'|uniq -d
echo ""
echo "Incomplete MAC address:"
arp -n|grep "incomplete"
