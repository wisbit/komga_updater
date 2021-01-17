These are 2 small scripts to install or rollback versions of jar file on linux.
It assumes that you have a komga.service enabled using "komga-running.jar"
It contains 2 shell scripts that will stop service, use a jar file placed in there if it had been downloaded before hand, or will download it itself.

It assumes a folder "archives" in which older versions of the jar files will be stored.
komga-version contains the version of the running jar file.

from the directory run
./update-komga.sh version  (eg: ./update-komga.sh 0.68.1 )
./rollback-version version

if the version isn't in the current directory the script will attempt downloading it.