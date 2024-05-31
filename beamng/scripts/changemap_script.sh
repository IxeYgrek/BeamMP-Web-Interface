#!/bin/sh

################################
#      Changement de MAP       #
################################

# Chemin relatif par rapport au répertoire du script

config_file="$(dirname "$0")/../config"

# Variables BDD MySQL

username=$(grep '^username=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
password=$(grep '^password=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
dbname=$(grep '^dbname=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')

# Variables emplacement des dossiers

BeamMPFolder=$(grep '^BeamMPFolder=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')
RootFolder=$(grep '^WebServerRootFolder=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')

# Autres variables

beammpservice=$(grep '^beammpservice=' "$config_file" | cut -d "=" -f2 | tr -d '[:space:]')




# Variables ID Map Active actuelle

id_map_active=$(mysql -D $dbname -u$username --password="$password" -N -e "SELECT id_beamng FROM beamng_mod WHERE map_active = 1;")

# Variable map actuelle officielle ou pas

official_map_active=$(mysql -D $dbname -u$username --password="$password" -N -e "SELECT map_officielle FROM beamng_mod WHERE map_active = 1;")

# Variable nouvelle map officielle ou pas

official_new_map=$(mysql -D $dbname -u$username --password="$password" -N -e "SELECT map_officielle FROM beamng_mod WHERE id_beamng = '$1';")

# Variable chemin du zip de la map active

chemin_zip_map_active=$(mysql -D $dbname -u$username --password="$password" -N -e "SELECT chemin FROM beamng_mod WHERE map_active = 1;")

# Variable chemin du zip de la nouvelle map

chemin_zip_new_map=$(mysql -D $dbname -u$username --password="$password" -N -e "SELECT chemin FROM beamng_mod WHERE id_beamng = '$1';")

# Variable nom du zip de la map active

nom_zip_map_active=$(mysql -D $dbname -u$username --password="$password" -N -e "SELECT chemin FROM beamng_mod WHERE map_active = 1;" | cut -d "/" -f8)

# Variable nom du zip de la nouvelle map

nom_zip_new_map=$(mysql -D $dbname -u$username --password="$password" -N -e "SELECT chemin FROM beamng_mod WHERE id_beamng = '$1';" | cut -d "/" -f8)





# On déplace la map actuelle dans le dossier des MOD inactifs si c'est une map non officielle

if [ "$official_map_active" -eq 0 ]; then
    mv "$chemin_zip_map_active" ${BeamMPFolder}Resources/inactive_map/
fi


# On déplace la nouvelle map depuis le dossier des MOD inactif si c'est une map non officielle

if [ "$official_new_map" -eq 0 ]; then
    mv "$chemin_zip_new_map" ${BeamMPFolder}Resources/Client/
fi

# On met à jour dans la base de données le chemin de la map active pour que ça corresponde au chemin des map inactive

if [ "$official_map_active" -eq 0 ]; then
    mysql -D $dbname -u$username --password="$password" -e "UPDATE gaming.beamng_mod SET chemin = REPLACE(chemin, 'Client', 'inactive_map') WHERE id_beamng = '$id_map_active';"
fi

# On met à jour dans la base de données le chemin de la nouvelle map pour que ça corresponde au chemin de la map active

if [ "$official_new_map" -eq 0 ]; then
    mysql -D $dbname -u$username --password="$password" -e "UPDATE gaming.beamng_mod SET chemin = REPLACE(chemin, 'inactive_map', 'Client') WHERE id_beamng = '$1';"
fi

# Mise à 0 de la valeur map_active pour la map active

mysql -D $dbname -u$username --password="$password" -e "UPDATE beamng_mod SET map_active = 0 WHERE id_beamng = '$id_map_active';"

# Valeur map_active à 1 pour la map choisi

mysql -D $dbname -u$username --password="$password" -e "UPDATE beamng_mod SET map_active = 1 WHERE id_beamng = '$1';"

# On remplace la map actuelle par la nouvelle MAP dans le fichier de conf du serveur

sed -i "s/$id_map_active/$1/g" ${BeamMPFolder}ServerConfig.toml

# On relance le serveur BeamNG

sudo /bin/systemctl restart $beammpservice
