#!/bin/bash 

KOMGA_PORT=2302

# Uncomment the following line to allocate more memory to Komga
# MEM_OPT=-Xmx512m

komga="komga-running.jar"
count=`pgrep -f $komga`

case "$1" in
        start)
			if [ -z "$count" ];
				then
				    nohup java $MEM_OPT -jar $komga --headless </dev/null &>komga.log &
					echo Komga has been started;
				else
					echo Komga is already running;
			fi            
            ;;
         
        stop)
			if [ -z "$count" ];
				then
				    echo Komga is NOT running, no need to stop it;
				else 
					echo stopping Komga...
					pkill -f "$komga" </dev/null &>/dev/null &
					echo Waiting 10 seconds before checking the server stopped...;
					sleep 10

					check=`pgrep -f $komga`
					if [ -z "$check" ];
						then
							echo Komga has been stopped;
						else
							echo Failed to stop Komga: you can either wait a few more seconds or kill it manually;
					fi
			fi
            ;;
         
        status)
			if [ -z "$count" ];
				then 
					echo Komga is NOT running;
				else
				    echo Komga is RUNNING;
			fi
            ;;
			
        *)
            echo $"Usage: $0 {start|stop|status}"
            exit 1
 
esac
