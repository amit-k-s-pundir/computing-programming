#!/bin/bash

echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted \
universe multiverse" | sudo tee -a /etc/apt/sources.list.d/ddebs.list

# stable releases (not alphas and betas) require three more lines
# added to the same file.
echo "deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main \
restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-security main \
restricted universe multiverse 
deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main \
restricted universe multiverse" | sudo tee -a /etc/apt/sources.list.d/ddebs.list
											  
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 428D7C01
