#!/bin/bash

projet="prosilabfruit"
instance="zakiinstsilabfruitins1"

install_conda () {
	#gcloud compute instances start $2
	gcloud compute ssh --project $1 --zone europe-west1-b $2 --command="wget -O - \
	https://raw.githubusercontent.com/mrNicky/automate_VM_GoogleCloud_AI/master/conda/conda_install.sh \
	| sudo bash && source ~/.bashrc \
	&& wget -O - https://raw.githubusercontent.com/mrNicky/automate_VM_GoogleCloud_AI/master/requirements.txt | sudo pip install -r && rm requirements.txt \
	rm anaconda.sh"
}

start_vm () {
 	gcloud compute instances start $instance
        gcloud compute ssh --project $1 --zone europe-west1-b $2
}
#install_conda $project $instance
#start_vm $projet $instance



install_conda $projet $instance
