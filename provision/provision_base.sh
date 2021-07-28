#!/usr/bin/env bash

sudo sed -i 's/archive.ubuntu.com/repos.uclv.edu.cu/' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/repos.uclv.edu.cu/' /etc/apt/sources.list

# Add authorized_keys uncomment below 
# echo "ssh-rsa " >> /home/vagrant/.ssh/authorized_keys
# echo "ssh-rsa ">> /home/vagrant/.ssh/authorized_keys

### Check if PROXY_Ip is NULL

if [ ! -n "${PROXY_IP}" ]
then
	echo "Not use proxy"
else
	sudo cat <<EOF > /etc/apt/apt.conf.d/proxy.conf
        Acquire {
        HTTP::proxy "http://${PROXY_IP}:${PROXY_PORT}";
        HTTPS::proxy "http://${PROXY_IP}:${PROXY_PORT}";
        }
EOF
fi



# change config sshd
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo service sshd restart

# actualizando

sudo apt update && sudo apt upgrade -y

# Instalando docker docker-compose

sudo apt install docker.io docker-compose -y

# creando daemon.json

sudo bash -c 'cat << EOF > /etc/docker/daemon.json
{
        "registry-mirrors": [
                "https://docker.uclv.cu"
        ]
}
EOF'


sleep 5

# Reiniciando docker
echo "Reiniciando servicio docker"
sudo service docker reload

sleep 5

# add vagrant into docker group
usermod -aG docker vagrant