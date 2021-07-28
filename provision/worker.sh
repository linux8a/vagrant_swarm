#!/usr/bin/env bash
sleep 10
docker swarm join --token `cat /vagrant/token` ${MANAGER_IP}:2377