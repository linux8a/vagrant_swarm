#!/usr/bin/env bash

docker swarm init --advertise-addr ${MANAGER_IP}
docker swarm join-token -q worker > /vagrant/token