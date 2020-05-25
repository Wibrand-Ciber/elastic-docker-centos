#!/bin/bash

#-------------------------
# GET A PASSWORD
#-------------------------
read -p "Enter a password for logging into Elasticsearch and Kibana: " -s ELASTIC_PASSWORD
export ES_PASSWORD=${ELASTIC_PASSWORD}

#-------------------------
# BOOTSTRAP ANSIBLE
#-------------------------
echo "Installing Ansible"
sudo yum clean all
sudo yum check-update
sudo yum install -y ansible
echo "Ansible has been installed"

#-------------------------
# ANSIBLE INSTALL DOCKER
#-------------------------
export DOCKER_COMPOSE_VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/docker/compose/releases/latest | awk -F / '{print $NF}')
export CURRENT_USER=$(whoami)
echo "Starting ansible playbook"
sudo ansible-playbook ./bootstrap.yml -e docker_compose_version=$DOCKER_COMPOSE_VERSION -e user=$CURRENT_USER
echo "Docker & docker-compose have been installed"


#-------------------------
# DEPLOY THE ELASTIC STACK
#-------------------------
echo "Starting elastic stack"
docker-compose up -d --force-recreate
echo "Elastic stack has started"

#-------------------------
# START `METRICBEAT`
#-------------------------
echo "Starting metricbeat on host"
sudo systemctl start metricbeat.service
echo "Metricbeat started"