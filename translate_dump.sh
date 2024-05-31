#!/bin/bash

# Fichiers de traduction et fichier dump
TRANSLATIONS_FILE="translations.txt"
DUMP_FILE="gaming_FR.sql"
DUMP_FILE_TRANSLATED="dump_translated.sql"

# Créez une copie du fichier dump original
cp $DUMP_FILE $DUMP_FILE_TRANSLATED

# Lire chaque ligne du fichier de traductions
while IFS="|" read -r original translation; do
    # Échappe les caractères spéciaux dans les chaînes original et translation
    escaped_original=$(printf '%s\n' "$original" | sed 's/[]\/$*.^[]/\\&/g')
    escaped_translation=$(printf '%s\n' "$translation" | sed 's/[&/\]/\\&/g')
    # Utiliser sed pour remplacer le texte original par la traduction
    sed -i -e "s/$escaped_original/$escaped_translation/g" $DUMP_FILE_TRANSLATED
done < $TRANSLATIONS_FILE

echo "La traduction est terminée. Le fichier traduit est : $DUMP_FILE_TRANSLATED"
