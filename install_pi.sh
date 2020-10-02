#!/bin/bash
# update
sudo apt update --yes
sudo apt upgrade --yes

# docker install
sudo apt install docker docker.io --yes
sudo usermod -aG docker $USER
sudo su - $USER

# docker-compose install
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# configure fstab
# get disk uuid with command 'sudo blkid'
sudo echo "UUID=132FB53A5DD07867 /media/hdd ntfs defaults 0 2" >> /etc/fstab

# mount now
DISK=$(sudo blkid | grep "132FB53A5DD07867" | awk '{print $1}')
DISK=${DISK::-1}
sudo mount -t "ntfs" -o rw $DISK /media/hdd

# configure docker
sudo mv /var/lib/docker/volumes /media/hdd/rasberry/docker/volumes
sudo ln -s /media/hdd/rasberry/docker/volumes /var/lib/docker/volumes


sudo systemctl enable docker
sudo systemctl start docker
