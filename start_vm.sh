#!/bin/bash

projet="prosilabfruit"
instance="didi5didi6"


start_vm () {
	gcloud compute instances start $instance
	gcloud compute ssh --project $1 --zone europe-west1-b $2 --command="wget -O - \
	https://raw.githubusercontent.com/mrNicky/automate_VM_GoogleCloud_AI/master/conda/conda_install.sh \
	sudo bash && source ~/.bashrc \
	&& conda activate"
}

start_vm $project $instance




