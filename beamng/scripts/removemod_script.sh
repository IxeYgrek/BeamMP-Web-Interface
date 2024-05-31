#!/bin/sh

################################
#     Suppression de MOD       #
################################

# La variable $1 correspond au chemin du zip du mod sélectionné pour suppression

# Chemin relatif par rapport au répertoire du script
config_file="$(dirname "$0")/../config"

# Variables BDD MySQL

username=$(grep '^username=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
password=$(grep '^password=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
dbname=$(grep '^dbname=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')

# Variables emplacement des dossiers

BeamMPFolder=$(grep '^BeamMPFolder=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
RootFolder=$(grep '^WebServerRootFolder=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]' | sed 's:/*$::')

# On récupère le chemin de l'image du MOD et de la preview

imagemod=$(mysql -D $dbname -u$username --password="$password" -N -e "select image from beamng_mod where chemin = '$1';")
imagepreview=$(mysql -D $dbname -u$username --password="$password" -N -e "select preview from beamng_mod where chemin = '$1';")

# On supprime le MOD et les images

rm -f $1
rm -f ${RootFolder}${imagemod}
rm -f ${RootFolder}${imagepreview}

# On supprime le MOD de la base de donnée

mysql -D $dbname -u$username --password="$password" -N -e "DELETE FROM beamng_mod WHERE chemin = '$1';"
