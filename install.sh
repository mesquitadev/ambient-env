#!/usr/bin/env bash

echo "#######################################################"
echo " Script de Instalação e configuração do ambiente Linux "
echo "    developed by: Victor Mesquita (@mesquitadev)       "
echo "                    Versão: 0.0.1                      "
echo "#######################################################"

USUARIO=`id -u`
UBUNTU=`lsb_release -rs`
KERNEL=`uname -r | cut -d'.' -f1,2`
LOG="/var/log/$(echo $0 | cut -d'/' -f2)"

if [ "$USUARIO" -eq "0" ] && (( $(echo "$KERNEL >= 4.15" |bc -l) ));
	then
		echo -e "O usuário e Root, continuando com o script..."
		echo -e "Distribuição e >=18.04.x, continuando com o script..."
		echo -e "Kernel e >= 4.15, continuando com o script..."
		sleep 5
	else
		echo -e "Usuário não e Root ($USUARIO) ou Distribuição não e >=18.04.x ($UBUNTU) ou Kernel não e >=4.15 ($KERNEL)"
		echo -e "Caso você não tenha executado o script com o comando: sudo -i"
		echo -e "Execute novamente o script para verificar o ambiente."
		exit 1
fi