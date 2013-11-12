#!/bin/bash

# Change these three variables to fit your needs
# Then run with ./opendns_updater.sh <interface name> <network label in OpenDNS dashboard>
# e.g. ./opendns_updater.sh eth0 MyNetwork

# Folder to store IP address cache file
IPFILEPATH="/tmp"

# Username for OpenDNS
# You are allowed to use the @ and . symbols
UPDATEUSER='youremail@goeshere.com'
# 
# Password for OpenDNS
UPDATEPASS='yourpasswordgoeshere'


###############################################

# Store parameters in more readable variable names
IFNAME="$1"
IFLABEL="$2"
 
# Authentication string for curl
# Colon symbol needed escaped for it to work
AUTHSTRING=${UPDATEUSER}\:${UPDATEPASS}

# Path to save the IP address
IPFILE=${IPFILEPATH}/opendns-${IFNAME}-${IFLABEL}.txt

if [ ! -e $IPFILE ]
then
    echo "1.1.1.1" > $IPFILE
fi

# Get current IP
CURRENTIP=`ifconfig $IFNAME | grep 'inet addr:'| cut -d: -f2 | awk '{ print $1}'`

# Get old IP
OLDIP=`cat "$IPFILE"`

echo "OLDIP: ${OLDIP}, CURRENTIP: ${CURRENTIP}"

if [ $OLDIP != $CURRENTIP ]
then
    echo "Different IPs, updating..."
    echo "$CURRENTIP" > $IPFILE
    echo "Running... curl --interface ${IFNAME} -u ${AUTHSTRING} https://updates.opendns.com/nic/update?hostname=${IFLABEL}"
    curl --interface ${IFNAME} -u ${AUTHSTRING} https://updates.opendns.com/nic/update?hostname=${IFLABEL}
fi
