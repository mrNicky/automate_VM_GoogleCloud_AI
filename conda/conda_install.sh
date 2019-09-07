#!/bin/bash

mkdir $HOME/.conda


#Set up VM with Anaconda
apt-get -y update
echo "install conda"
#Install Anaconda
#TO DO: force all command yes
apt-get -y install bzip2 libxml2-dev
wget https://repo.continuum.io/archive/Anaconda3-2019.07-Linux-x86_64.sh -O ~/anaconda.sh
bash ~/anaconda.sh -b -p $HOME/anaconda


export PATH=~/anaconda/bin:$PATH
conda init bash
source ~/.bashrc 
conda activate 
#exit 2
#gcloud compute instances stop $instance 

