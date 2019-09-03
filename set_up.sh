#!/bin/bash
read -p 'entrer le nom de votre projet : ' projet
read -p 'entrer le nombre de votre instance : ' instance
read -p 'pour vous connecter sans recreer de vm, taper Y sinon N : ' Y

sudo -s

if [ $Y = "Y" ]
then 
	gcloud config set project $projet
	gcloud compute ssh --project $projet --zone europe-west1-b $instance
else
	read -p 'entrer le nombre de VM que vous souhaitez : ' N

	#Logging and Install and update 
	gcloud auth login && sudo snap install google-cloud-sdk --classic
	v = gcloud version | grep -m1 -o -E '[0-9|.]+'
	gcloud components update $v

	#Create project
	#$1 = name project
	#--- TO DO: check if project exist else create this project
	gcloud projects create $projet && gcloud config set project $_

	#Create instance from ubuntu:1804:lts
	for i in {1..$N}; do gcloud compute instances create $instance_$i \
		--image-family ubuntu-1804-lts --image-project gce-uefi-images --zone europe-west1-b; done

	#Connect to vm instance and generate ssh key
	gcloud compute ssh --project $projet --zone europe-west1-b $instance

	#Install Anaconda
	#TO DO: force all command yes
	apt-get update
	apt-get install bzip2 libxml2-dev
	wget https://repo.anaconda.com/archive/Anaconda2-2019.07-Linux-x86_64.sh 
	bash Anaconda2-2019.07-Linux-x86_64.sh && rm $_
	source .bahsrc

fi
