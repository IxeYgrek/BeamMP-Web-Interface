#!/bin/sh

################################
#         Upload de MOD        #
################################

# Fonction pour échapper les caractères spéciaux dans une chaîne
escape_string() {
    printf '%s' "$1" | sed -e "s/'/''/g"
}

# Chemin relatif par rapport au répertoire du script

config_file="$(dirname "$0")/../config"

# Variables BDD MySQL

username=$(grep '^username=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
password=$(grep '^password=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
dbname=$(grep '^dbname=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
tablename=$(grep '^tablename=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')

# Variables emplacement des dossiers

BeamMPFolder=$(grep '^BeamMPFolder=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
RootFolder=$(grep '^WebServerRootFolder=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')

# Variables récupérées du formulaire d'envoi

modname="$1"
moddescription="$2"
modtype="$3"
modimage="$4"
modpreview="$5"
modzip="$6"
idbeamng="$7"

# Échapper les caractères spéciaux

escaped_modname=$(escape_string "$modname")
escaped_moddescription=$(escape_string "$moddescription")
escaped_modimage=$(escape_string "$modimage")
escaped_modpreview=$(escape_string "$modpreview")
escaped_modzip=$(escape_string "$modzip")

# Vérifier si escaped_modpreview est vide et le remplacer si nécessaire

if [ -n "$escaped_modpreview" ]; then
  escaped_modpreview="/beamng/preview_map/preview_$escaped_modzip.jpg"
fi

# Vérifier si le mod est une MAP ou pas et définir s'il va dans le dossier inactive_map ou Client

if [ "$modtype" = "map" ]; then
mod_folder="inactive_map"
else
mod_folder="Client"
fi

# On inscrit le MOD en base de donnée

mysql -D $dbname -u$username --password="$password" -N -e "SET NAMES 'utf8mb4';INSERT INTO ${dbname}.${tablename} (nom, description, type, chemin, image, preview, id_beamng, map_active, map_officielle, mod_actif) VALUES ('$escaped_modname', '$escaped_moddescription', '$modtype', '${BeamMPFolder}Resources/$mod_folder/$escaped_modzip', '/beamng/image_$modtype/image_$escaped_modzip.jpg', '$escaped_modpreview', '$idbeamng', 0, 0, 0);"

# On renomme l'image du MOD et on la déplace au bon endroit selon le type de MOD

mv "${RootFolder}beamng/TEMP/${modimage}" "${RootFolder}beamng/image_${modtype}/image_${modzip}.jpg"

# On renomme la  preview de la MAP si elle existe et on la déplace au bon endroit

if [ -n "$modpreview" ]; then
mv "${RootFolder}beamng/TEMP/${modpreview}" "${RootFolder}beamng/preview_map/image_${modzip}.jpg"
fi

# On déplace le ZIP du MOD dans le dossier inactive_map ou Client selon si c'est une MAP ou pas

mv "${RootFolder}beamng/TEMP/${modzip}" "${BeamMPFolder}Resources/${mod_folder}/${modzip}"
