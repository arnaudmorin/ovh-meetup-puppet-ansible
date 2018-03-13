#!/bin/bash

function boot(){(
    NAME=$1
    IP=$2
    openstack server create \
        --key-name arnaud-ovh \
        --nic net-id=Ext-Net \
        --image 'Ubuntu 16.04' \
        --flavor c2-7 \
        --user-data userdata/${NAME/-[0-9]*/} \
        $NAME
)}

#boot jump
boot web_puppet
