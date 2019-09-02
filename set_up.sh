#!/bin/bash
read -p 'entrer le nom de votre projet : ' projet
read -p 'entrer le nombre de votre instance : ' instance
read -p 'pour vous connecter sans recreer de vm, taper Y sinon N ; ' Y


if [ $Y = "y" ]
then 
	gcloud config set project $projet
	gcloud compute ssh --project $projet --zone europe-west1-b $instance
else

	#Logging and Install and update 
	gcloud auth login && sudo snap install google-cloud-sdk --classic
	v = gcloud version | grep -m1 -o -E '[0-9|.]+'
	gcloud components update $v

	#Create project
	#$1 = name project
	#--- TO DO: check if project exist else create this project
	gcloud projects create $projet &&  gcloud config set project $_


	#Create instance from ubuntu:1804:lts
	#$2 = name instance
	gcloud compute instances create $instance --image-family ubuntu-1804-lts --image-project gce-uefi-images --zone europe-west1-b

	#Connect to vm instance and generate ssh key
	gcloud compute ssh --project $projet --zone europe-west1-b $instance


	#Install docker
	sudo s-
	apt-get update
	apt-get remove docker docker-engine docker.io
	apt install docker.io
	#systemctl start docker
	#systemclt enable docker

	#Install Anaconda
	#TO DO: force all command yes
	apt-get update
	apt-get install bzip2 libxml2-dev
	wget https://repo.anaconda.com/archive/Anaconda2-2019.07-Linux-x86_64.sh 
	bash Anaconda2-2019.07-Linux-x86_64.sh && rm $_
	source .bahsrc

fi
