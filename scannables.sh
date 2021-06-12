#!/bin/bash
# Start scannable containers
# scannables.sh [start|stop] [ number of containers ]
RUNNERS=$2
COUNT=0
case $1 in 
	start)
		echo "Starting $RUNNERS scannable containers";
		while [ $COUNT -lt $RUNNERS ]; do
			docker run -d --rm --name scannable-$COUNT  scannable 
			sleep 3
			if [ $? -eq 0 ]; then
			        IPS="$IPS $COUNT:$(docker logs scannable-$COUNT | awk /inet/'{print $2}'  | grep -v 127.0.0.1)"
				COUNT=$( expr $COUNT + 1 )
				
			else
				echo " Failed to start container $COUNT"
				exit
			fi
		done
		docker ps 
		echo "Container IPs"
		echo $IPS | sed -e "s/.://g;s/\/16//g"
	;;
	stop)
		echo "Stopping all scannable containers."
		docker stop $( docker ps | awk /scannable/'{print $1'} ) 

	;;
	*)
		echo " You need to specify some options"
		echo " scannable.sh <start || stop> [ # of containers to start ]"
		exit
	;;

esac 

