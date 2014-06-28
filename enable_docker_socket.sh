#!/bin/bash

cp /home/core/docker-tcp.socket /etc/systemd/system

systemctl enable docker-tcp.socket
systemctl stop docker
systemctl start docker-tcp.socket
systemctl start docker
docker -H tcp://127.0.0.1:2375 ps
