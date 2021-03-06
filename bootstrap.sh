#!/bin/bash

function boot(){(
    NAME=$1
    IP=$2
    USERDATA=userdata/${NAME/-[0-9]*/}

    cp $USERDATA /tmp/userdata__$$
    sed -i -r "s/__OS_USERNAME__/$OS_USERNAME/" /tmp/userdata__$$
    sed -i -r "s/__OS_PASSWORD__/$OS_PASSWORD/" /tmp/userdata__$$
    sed -i -r "s/__OS_TENANT_NAME__/$OS_TENANT_NAME/" /tmp/userdata__$$
    sed -i -r "s/__OS_TENANT_ID__/$OS_TENANT_ID/" /tmp/userdata__$$
    sed -i -r "s/__OS_REGION_NAME__/$OS_REGION_NAME/" /tmp/userdata__$$

    openstack server create \
        --key-name arnaud-ovh \
        --nic net-id=Ext-Net \
        --image 'Ubuntu 16.04' \
        --flavor c2-7 \
        --user-data /tmp/userdata__$$ \
        $NAME

    rm /tmp/userdata__$$
)}

boot jump
boot web-puppet
boot web-ansible
