# elastic-docker-centos
Project to install and run a 3 node elasticsearch cluster on a CentOS 8 host.

This project installs ansible on a centos8 host and then uses ansible to setup docker.
Docker-compose is then used to create and run a 3 node elasticsearch cluster with a kibana instance as docker containers.
Ansible also installs Metricbeat on the host for self monitoring on system and docker engine level.

Git clone the repo on your host, cd into the directory and execute:
```
sudo ./quick-deploy.sh
```