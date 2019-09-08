#!/bin/bash

echo Entrer votre login google cloud pour commencer : `gcloud auth login`

install_conda () {
	gcloud compute instances start $2 --zone europe-west1-b
        gcloud compute ssh --project $1 --zone europe-west1-b $2 --command="wget -O - \
        https://raw.githubusercontent.com/mrNicky/automate_VM_GoogleCloud_AI/master/conda/conda_install.sh \
        | sudo bash && source ~/.bashrc \
	&& conda install --file"
}

start_vm () {
        gcloud compute instances start $2 --zone europe-west1-b
        gcloud compute ssh --project $1 --zone europe-west1-b $2
}

stop_vm () {

	gcloud compute instances stop $1
}


read -p 'entrer le nom de votre projet : ' projet
read -p 'entrer le nom de base de votre instance : ' instance
read -p 'souhaitez-vous arrêter votre vm Y/n : ' stopvm
read -p 'pour vous connecter sans recreer de vm, taper Y sinon N : ' Y

projet=${projet}"mldeep101PROJET"
instance=${instance}"mldeep101INSTANCE"


if [ $Y = "Y" ]
then 
	gcloud config set project $projet
	start_vm $projet $instance
elif [ $stopvm = "Y" ]
then
	stop_vm $instance

else
	gcloud projects create $projet && gcloud config set project $_
	"INSTALLATION GOOGLE CLOUD AND BILLING  -------------->"
	sudo apt -y install snapd
	sudo snap install google-cloud-sdk --classic
	gcloud alpha billing projects link $projet --billing-account `gcloud alpha billing accounts list | grep -o '^[A-Z0-9-]*' | tail -n1`
	
	echo "CREATE INSTANCE -------------->"
	gcloud compute instances create $instance \
	--image-family ubuntu-1804-lts --image-project gce-uefi-images --zone europe-west1-b \
	--machine-type n1-standard-2 --accelerator type=nvidia-tesla-k80,count=1 \ 
	 --maintenance-policy TERMINATE --restart-on-failure \
	 --metadata startup-script='#!/bin/bash
    echo "Checking for CUDA and installing."
    # Check for CUDA and try to install.
    if ! dpkg-query -W cuda-10-0; then
      curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
      dpkg -i ./cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
      apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
      apt-get update
      apt-get install cuda-10-0 -y
    fi'
	
	install_conda $projet $instance
	start_vm $projet $instance
	fi
