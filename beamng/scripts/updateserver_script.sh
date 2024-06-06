#!/bin/sh

################################
#         Server Update        #
################################

# Chemin relatif par rapport au répertoire du script

config_file="$(dirname "$0")/../config"

# Variables emplacement des dossiers

BeamMPFolder=$(grep '^BeamMPFolder=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
RootFolder=$(grep '^WebServerRootFolder=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')

# Variable service BeamMP

beammpservice=$(grep '^beammpservice=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')

# Variable dernière version BeamMP

beammpversion=$(curl -s https://api.github.com/repos/BeamMP/BeamMP-Server/releases/latest | grep "tag_name" | cut -d '"' -f 4)

# Variable version BeamMP actuellement installée

beammpactualversion=$(cat ${BeamMPFolder}Server.log | grep "BeamMP Server v" | cut -d ' ' -f6)

# Variable Ubuntu version

ubuntuversion=$(hostnamectl | grep Operating | cut -d ' ' -f4 | cut -d '.' -f1-2)

# On fait quelque chose uniquement si les versions sont différentes

if [ "$beammpversion" != "$beammpactualversion" ]; then

# Stopper le service BeamMP

sudo /bin/systemctl stop $beammpservice

sleep 5

# Supprimer la version actuelle

rm ${BeamMPFolder}BeamMP-Server.ubuntu*

# Télécharger la dernière version

wget -O ${BeamMPFolder}BeamMP-Server.ubuntu.${ubuntuversion}.x86_64 https://github.com/BeamMP/BeamMP-Server/releases/download/${beammpversion}/BeamMP-Server.ubuntu.${ubuntuversion}.x86_64

# On rend le fichier exécutable

sudo chmod +x ${BeamMPFolder}BeamMP-Server.ubuntu.${ubuntuversion}.x86_64

# On supprime le fichier de log

rm ${BeamMPFolder}Server.log

# Démarrer le service

sudo /bin/systemctl start $beammpservice

fi
