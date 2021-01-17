#!/bin/bash
rollbackversion=$1;
if [[ $# -eq 0 ]]; then
	echo "No version provided!";
	echo " ";
	echo "Usage: ./rollback-komga.sh [option] rollback-version";
	echo "eg: ./rollback-version.sh 0.68.1";
	echo "-n  : doesn't start the service after the update"
	echo "If it's not in the archives folder, the script will attempt downloading it.";
	echo " ";
	exit 1;
fi
found=0;
for f in archives/* 
	do
		echo ${f};
	if [[ ${f} == "archives/komga-${rollbackversion}.jar" ]]; then
		found=1;
	fi
	if [[ ${f} == "archives" ]]; then
		archives=1;
	fi
done

if (( ${archives}==0  )); then
       sudo mkdir archives;
       sudo chown $USER:$USER archives;
       sudo chmod 755 archives;
fi

if (( ${found}==0  )); then
    wget "https://github.com/gotson/komga/releases/download/v${rollbackversion}/komga-${rollbackversion}.jar";
else
	sudo mv "archives/komga-${rollbackversion}.jar" "komga-${rollbackversion}.jar";
fi





#if [[ ${f} == *"${rollbackversion}.jar" && ${f} != "komga-latest.jar" ]]; then
#			found=1;
			echo "stopping service ... ";
			echo " ";
			sudo systemctl stop komga.service
			./run-komga.sh status;



			runningversion=`cat komga-version`;

			echo "Updating";
			echo " ";
			echo "Back Up old version komga-${lastversion}.jar";
			echo " ";
			#echo $lastversion;

			sudo mv "komga-running.jar" "komga-${runningversion}.jar";




			#echo "${f}";
			
#			rollbackversion=${f:6:-4};
			sudo mv "komga-${rollbackversion}.jar" "komga-running.jar"
			echo "Installing new version komga-${rollbackversion}.jar";
			echo " ";
			echo -n $rollbackversion > komga-version;
			echo "Starting service ... ";
			echo " ";
			sudo systemctl start komga.service
			./run-komga.sh status;

#		fi

#done

#if (( ${found} == 0  )); then
#	echo "new version not found";
#fi

