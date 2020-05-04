#!/bin/bash -e

#-------------------------
# GET A PASSWORD
#-------------------------
read -p "Enter a password for logging into Elasticsearch and Kibana: " -s ELASTIC_PASSWORD
export ES_PASSWORD=${ELASTIC_PASSWORD}

#-------------------------
# BOOTSTRAP ANSIBLE
#-------------------------
sudo yum clean all
sudo yum check-update
sudo yum -y install ansible

#-------------------------
# ANSIBLE INSTALL DOCKER
#-------------------------
export CURRENT_USER=$(whoami)
ansible-playbook ./bootstrap.yml

#-------------------------
# DEPLOY THE ELASTIC STACK
#-------------------------
docker-compose up -d --force-recreate