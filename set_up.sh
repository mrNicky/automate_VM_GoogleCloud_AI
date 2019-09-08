#!/bin/bash
#read -p 'entrer le nom de votre projet : ' projet
#read -p 'entrer le nom de base de votre instance : ' instance
read -p 'pour vous connecter sans recreer de vm, taper Y sinon N : ' Y

#projet=${projet}silabfruit
#instance=${instance}silabfruitins
projet="prosilabfruit"
#instance=${instance}"instsilabfruitins1"
instance="gogo123gogo"

#Connect and install Anaconda
install_conda () {
	echo "install conda"
# addzone	gcloud compute instances start $2
        gcloud compute ssh --project $1 --zone europe-west1-b $2 --command="wget -O - \
        https://raw.githubusercontent.com/mrNicky/automate_VM_GoogleCloud_AI/master/conda/conda_install.sh \
        | sudo bash && source ~/.bashrc \
	&& conda install --file"
}

start_vm () {
        gcloud compute instances start $2
        gcloud compute ssh --project $1 --zone europe-west1-b $2
}

if [ $Y = "Y" ]
then 
	gcloud config set project $projet
	start_vm $projet $instance
else
#	read -p 'entrer le nombre de VM que vous souhaitez : ' N
	
	echo "install snapd"
	#Logging and Install and update 
	sudo apt -y install snapd

	echo "install sdk"
	sudo snap install google-cloud-sdk --classic
	
	echo "update gcloud"
	#v=`gcloud version | grep -m1 -o -E '[0-9|.]+'`
	#gcloud components update $v --quiet
	
	echo "creatE PROJECT ---------"
	#Create project
	#$1 = name project
	#--- TO DO: check if project exist else create this project
	#gcloud projects create $projet && gcloud config set project $_

	gcloud alpha billing projects link $projet --billing-account `gcloud alpha billing accounts list | grep -o '^[A-Z0-9-]*' | tail -n1`
	
	#Create instance from ubuntu:1804:lts
	#for (( i=1; i <= $N; i=++i ));do 
	#gcloud compute instances create $instance \
	#--image-family ubuntu-1804-lts --image-project gce-uefi-images --zone europe-west1-b
	#instance=$instance$i
	echo "INSTALL CONDA -------------"
	install_conda $projet $instance

	echo "INSTALL LIBRAIRIES TO DO ----------"
	
	
	
	
	start_vm $projet $instance
	fi
