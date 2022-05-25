#!/bin/bash
echo "Aprovisionamiento Iniciado..."
echo "Ingresar como megaUsuario"
sudo -i
sudo echo "nameserver 192.168.50.101" >> /etc/resolv.conf
sudo yum -y install vim
sudo yum -y install wget
sudo wget --no-cookies --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"
sudo yum -y localinstall jdk-8u131-linux-x64.rpm
sudo wget https://github.com/streamaserver/streama/releases/download/v1.10.4/streama-1.10.4.jar 
sudo mkdir /opt/streama
sudo mv streama-1.10.4.jar /opt/streama/streama.war
sudo mkdir /opt/streama/media
sudo chmod 777 /opt/streama/media
sudo chmod 777 /etc/systemd/system
echo "Iniciando el servicio de Streama"
sudo service streama start
sudo systemctl enable streama
echo "Felicitaciones se configuro con exito!! :)"
