#!/bin/bash

projet="prosilabfruit"
instance="didi5didi"

start_vm () {
        gcloud compute instances start $instance
        gcloud compute ssh --project $1 --zone europe-west1-b $2 \
        && sudo -s
}


start_vm $projet $instance

