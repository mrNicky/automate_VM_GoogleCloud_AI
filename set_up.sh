#!/bin/bash
read -p 'entrer le nom de votre projet : ' projet
read -p 'entrer le nom de base de votre instance : ' instance
read -p 'pour vous connecter sans recreer de vm, taper Y sinon N : ' Y

#projet=${projet}silabfruit
#instance=${instance}silabfruitins
projet="prosilabfruit"
instance="instsilabfruitins1"

#echo "connexion a votre compte cloud google $(gcloud auth login)" 

#Connect to vm instance and generate ssh key
start_vm () {
	gcloud compute instances start $instance
	gcloud compute ssh --project $1 --zone europe-west1-b $2 
	sudo -s
}

if [ $Y = "Y" ]
then 
	gcloud config set project $projet
	start_vm $projet $instance
else
	read -p 'entrer le nombre de VM que vous souhaitez : ' N
	
	#Logging and Install and update 
	sudo apt -y install snapd
	sudo snap install google-cloud-sdk --classic
	v=gcloud version | grep -m1 -o -E '[0-9|.]+'
	gcloud components update $v
	
	echo "create project"
	#Create project
	#$1 = name project
	#--- TO DO: check if project exist else create this project
	gcloud projects create $projet && gcloud config set project $_

	gcloud alpha billing projects link $projet --billing-account `gcloud alpha billing accounts list | grep -o '^[A-Z0-9-]*' | tail -n1`

	echo "loop"
	#Create instance from ubuntu:1804:lts
	for (( i=1; i <= $N; ++i ));do gcloud compute instances create $instance$i \
		--image-family ubuntu-1804-lts --image-project gce-uefi-images --zone europe-west1-b
		instance=$instance$i
		echo "strating instance"
		start_vm $projet $instance
		
		#apt-get update
		echo "install conda";done
		#Install Anaconda
		#TO DO: force all command yes
#		apt-get install bzip2 libxml2-dev
#		wget https://repo.anaconda.com/archive/Anaconda2-2019.07-Linux-x86_64.sh 
#		bash Anaconda2-2019.07-Linux-x86_64.sh && rm $_
#		source .bahsrc
#		exit 2 
#		gcloud compute instances stop $instance 


	fi
