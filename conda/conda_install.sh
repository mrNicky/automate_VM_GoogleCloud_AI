#!/bin/bash

#Set up VM with Anaconda
apt-get -y update
echo "install conda"
#Install Anaconda
#TO DO: force all command yes
apt-get -y install bzip2 libxml2-dev
wget https://repo.anaconda.com/archive/Anaconda2-2019.07-Linux-x86_64.sh
bash Anaconda2-2019.07-Linux-x86_64.sh && rm $_
source ~/.bashrc
exit 2
#gcloud compute instances stop $instance 

