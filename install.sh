#!/usr/bin/env bash


USUARIO=`id -u`
UBUNTU=`lsb_release -rs`
KERNEL=`uname -r | cut -d'.' -f1,2`
LOG="/var/log/$(echo $0 | cut -d'/' -f2)"

clear
if [ "$USUARIO" -eq "0" ] && (( $(echo "$KERNEL >= 4.15" |bc -l) ));
	then
		echo -e "O usuário e Root, continuando com o script..."
		echo -e "Kernel e >= 4.15, continuando com o script..."
		sleep 5
	else
		echo -e "Usuário não e Root ($USUARIO) ou Kernel não e >=4.15 ($KERNEL)"
		echo -e "Caso você não tenha executado o script com o comando: sudo -i"
		echo -e "Execute novamente o script para verificar o ambiente."
		exit 1
fi
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
echo "#######################################################"
echo " Script de Instalação e configuração do ambiente Linux "
echo "    developed by: Victor Mesquita (@mesquitadev)       "
echo "                    Versão: 0.0.1                      "
echo "#######################################################"

echo -e "Aguarde, esse processo demora um pouco dependendo do seu Link de Internet..."
sleep 5
echo
#
echo -e "Adicionando o Repositório Universal do Apt, aguarde..."
  add-apt-repository universe &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando as listas do Apt, aguarde..."
  apt update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando o sistema, aguarde..."
	apt -y upgrade &>> $LOG
echo -e "Sistema atualizado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Removendo software desnecessários, aguarde..."
	apt -y autoremove &>> $LOG
echo -e "Software removidos com sucesso!!!, continuando com o script..."
sleep 5
echo
clear
#
echo -e "Instalando GIT, aguarde..."
  apt install git -y &>> $LOG
  clear
echo -e "Git Instalado com sucesso!!!, continuando com o script..."
sleep 5
echo
clear
#
echo -e "Instalando PHP, aguarde..."
  apt install php -y &>> $LOG
  clear
echo -e "PHP Instalado com sucesso!!!, continuando com o script..."
sleep 5
echo
clear
#
echo -e "Instalando GUAKE, aguarde..."
  apt install guake -y &>> $LOG
  clear
echo -e "GUAKE Instalado com sucesso!!!, continuando com o script..."
sleep 5
echo
clear
#
echo -e "Instalando Postman, aguarde..."
  # Install postman
wget https://dl.pstmn.io/download/latest/linux64-O postman.tar.gz &>> $LOG
sudo tar -xzf postman.tar.gz -C /opt &>> $LOG
rm postman.tar.gz &>> $LOG
sudo ln -s /opt/Postman/Postman /usr/bin/postman &>> $LOG

cat > ~/.local/share/applications/postman.desktop <<EOL
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOL
echo -e "Postman Instalado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalando COMPOSER, aguarde..."
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer &>> $LOG
  clear
echo -e "COMPOSER Instalado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalando ZSH, aguarde..."
  apt install zsh &>> $LOG
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &>> $LOG
  clear
echo -e "ZSH Instalado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalando Docker e docker-compose, aguarde..."
  curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh &>> $LOG
  apt install docker-compose -y &>> $LOG
  clear
echo -e "ZSH Instalado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Adicionando Docker ao Grupo de Permissões, aguarde..."
  # https://docs.docker.com/install/linux/linux-postinstall/
  sudo groupadd docker &>> $LOG
  sudo usermod -aG docker $USER &>> $LOG
  clear
echo -e "Usuário adicionado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação do script feita com Sucesso!!!"
	# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
	# opção do comando date: +%T (Time)
	HORAFINAL=`date +%T`
	# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
	HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
	HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
	# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second),
	TEMPO=`date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S"`
	# $0 (variável de ambiente do nome do comando)
	echo -e "Tempo gasto para execução do script $0: $TEMPO"
echo -e "Pressione <Enter> para concluir o processo."
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
read
exit 1
