#!/bin/bash
#
# runs a socat file transfer over the loopback interface 

mkdir results
echo -e "foo\nbar\nbaz\nhello\nYAY" > results/foo.txt
dumpcap -i lo -a duration:10 -w results/lo.pcap -p &
dumpcap_pid=$!
sleep 1
socat -u TCP-LISTEN:12345,bind=127.0.0.1,reuseaddr OPEN:results/socat-listen.log,creat,append &
sleep 1
socat -u FILE:results/foo.txt TCP:127.0.0.1:12345

wait "$dumpcap_pid"
