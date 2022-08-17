#!/bin/bash
logfile='/home/kali/Desktop/logfile.txt'

`truncate -s 0 logfile.txt`										# clear log file (allows for automation)

if [ $# -eq 0 ]; then

	for i in $(seq 2 254) 										# for loop 1 through 255
	do 												
		p="192.168.1.$i"									# current ip
		ping=`ping -c1 $p | grep -o 'Destination Host Unreachable'`				# ping it			
		
		if [ "$ping" = "Destination Host Unreachable" ]; then	 				# host is down
			echo Host $p is down 								# print host is down	
		else 											# host is not down								
			scan=`timeout 20 nmap -T5 -A -v -sV $p`						# nmap ip
			ports=`echo $scan | grep -o '\w\+/tcp' | sort -u | tr -d '/tcp'`		# get open ports		
			echo $p $ports >> $logfile							# write to log file
		fi
	done

elif [ $# -eq 1 ]; then

	p=$1											# ip from command line
	ping=`ping -c1 $p | grep -o 'Destination Host Unreachable'`				# ping it		
	
	if [ "$ping" = "Destination Host Unreachable" ]; then	 				# host is down
		echo Host $p is down 								# print host is down	
	else 											# host is not down								
		scan=`timeout 20 nmap -T5 -A -v -sV $p`						# nmap ip
		ports=`echo $scan | grep -o '\w\+/tcp' | sort -u | tr -d '/tcp'`		# get open ports		
		echo $p $ports >> $logfile							# get open ports
	fi

elif [ $# -eq 2 ]; then

	if [ "$1" -gt 0 ] && [ "$1" -lt 255 ] && [ "$2" -gt 0 ] && [ "$2" -lt 255 ] && [ "$1" -lt "$2" ]; then		# ensure input is valid
		for i in $(seq $1 $2) 											# for loop 1 through 255
		do 												
			p="192.168.1.$i"										# current ip
			ping=`ping -c1 $p | grep -o 'Destination Host Unreachable'`					# ping it			
			
			if [ "$ping" = "Destination Host Unreachable" ]; then	 					# host is down
				echo Host $p is down 									# print host is down	
			else 												# host is not down								
				scan=`timeout 20 nmap -T5 -A -v -sV $p`							# nmap ip
				ports=`echo $scan | grep -o '\w\+/tcp' | sort -u | tr -d '/tcp'`			# get open ports		
				echo $p $ports >> $logfile								# write to log file
			fi
		done
	fi	
fi
