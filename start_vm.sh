#!/bin/bash

projet="prosilabfruit"
instance="didi5didi6"

start_vm () {
        gcloud compute instances start $instance
        gcloud compute ssh --project $1 --zone europe-west1-b $2
}


start_vm $projet $instance

