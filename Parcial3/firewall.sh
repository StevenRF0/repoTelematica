#!/bin/bash
echo "Aprovisionamiento Iniciado..."
echo "Ingresar como megaUsuario"
sudo -i
echo "Instalando herramientas vim y net-tools"
sudo yum -y install vim net-tools

echo "Configuración del redireccionamiento"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

echo "Iniciando los servicios y chkconfig del firewall"
sudo service firewalld start
sudo chkconfig firewalld on

echo "configurando de la zona internal y sus reglas"
sudo firewall-cmd --permanent --zone=internal --add-interface=eth1
sudo firewall-cmd --permanent --zone=internal --add-service=http 
sudo firewall-cmd --permanent --zone=internal --add-port=80/tcp 
sudo firewall-cmd --permanent --zone=internal --add-port=8080/tcp 
sudo firewall-cmd --permanent --zone=internal --add-masquerade
sudo firewall-cmd --permanent --zone=internal --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=192.168.50.101
sudo firewall-cmd --permanent --zone=internal --add-forward-port=port=8080:proto=tcp:toport=8080:toaddr=192.168.50.101

echo "configurando de la zona publica y sus reglas"
sudo firewall-cmd --permanent --zone=public --add-interface=eth2
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp 
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp 
sudo firewall-cmd --permanent --zone=public --add-masquerade 
sudo firewall-cmd --permanent --zone=public --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=192.168.50.101
sudo firewall-cmd --permanent --zone=public --add-forward-port=port=8080:proto=tcp:toport=8080:toaddr=192.168.50.101
sudo firewall-cmd --reload
echo "Felicitaciones se configuro con exito!! :)"