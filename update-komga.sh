#!/bin/bash
newversion=$1;
if [[ $# -eq 0 ]]; then
	echo "No version provided!";
	echo " ";
	echo "Usage: ./update-komga.sh [version]";
	echo "If the new jar file is not in the current folder, the script will attempt downloading it.";

	echo " ";
	exit 1;
fi
found=0;
archives=0;
for f in * 
	do
	if [[ ${f} == "komga-${newversion}.jar" ]]; then
		found=1;
	fi
	if [[ ${f} == "archives" ]]; then
		archives=1;
	fi
done



if (( ${found} == 0  )); then
       wget "https://github.com/gotson/komga/releases/download/v${newversion}/komga-${newversion}.jar";
fi
if (( ${archives} == 0  )); then
       sudo mkdir archives;
       sudo chown $USER:$USER archives;
       sudo chmod 755 archives;
fi



			echo "stopping service ... ";
			echo " ";
			sudo systemctl stop komga.service
			./run-komga.sh status;



			runningversion=`cat komga-version`;

			echo "Updating";
			echo " ";
			echo "Back Up old version komga-${runningversion}.jar";
			echo " ";
			sudo mv "komga-running.jar" "archives/komga-${runningversion}.jar";

			sudo mv "komga-${newversion}.jar" "komga-running.jar"
			echo "Installing new version komga-${newversion}.jar";
			echo " ";
			echo -n $newversion > komga-version;
			echo "Starting service ... ";
			echo " ";
			sudo systemctl start komga.service
			./run-komga.sh status;

#		fi

#done

#if (( ${found} == 0  )); then
#	echo "new version not found";
#fi

