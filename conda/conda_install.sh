#!/bin/bash

#Set up VM with Anaconda

#apt-get update
echo "install conda"
#Install Anaconda
#TO DO: force all command yes
sudo apt-get install bzip2 libxml2-dev
sudo wget https://repo.anaconda.com/archive/Anaconda2-2019.07-Linux-x86_64.sh
sudo bash Anaconda2-2019.07-Linux-x86_64.sh && rm $_
source .bahsrc
exit 2
#gcloud compute instances stop $instance 
