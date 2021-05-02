# scannable
A scannable container to test my GVM/openvas container. 
Get the start script on github at:
https://github.com/immauss/scannable
scannable.sh <[start|stop]> [ number of containers ]

It really only uses the memory of single bash instance and an instance of sshd, so you should be albe to run a bunch of them. The script will pop out the IPs of all the containers for the scan. 
