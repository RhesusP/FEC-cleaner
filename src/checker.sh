#!/bin/bash

# ------------------------------------------------------------------------------
# Script for FEC_cleaner project
# ------------------------------------------------------------------------------
# Author: Camille BERNOT (camil.bernot.cb@gmail.com)
# Description: Bash script to check if the number of lines in the original and
# cleaned files are the same.
# Version: 0.1
# Date: 2024-06-26
# ------------------------------------------------------------------------------

# Vérifier si au moins un nom de fichier a été fourni
if [ $# -eq 0 ]; then
  echo "⚠️ Usage: $0 <fichier1> [fichier2] ..."
  exit 1
fi

# Boucler sur tous les noms de fichiers passés en paramètres
for fichier in "$@"; do
  # Construire le nom du fichier "clean"
  fichier_clean="${fichier%.*}_clean.${fichier##*.}"

  # Vérifier si les fichiers existent
  if [ ! -f "$fichier" ] || [ ! -f "$fichier_clean" ]; then
    echo -e "\033[1;93m⚠️  L'un des fichiers ($fichier ou $fichier_clean) n'existe pas.\033[0m"
    continue
  fi

  # Compter le nombre de lignes dans chaque fichier
  lignes_fichier=$(wc -l < "$fichier")
  lignes_fichier_clean=$(wc -l < "$fichier_clean")

  # Comparer le nombre de lignes
  if [ "$lignes_fichier" -eq "$lignes_fichier_clean" ]; then
    echo -e "\033[1;32m✅ $fichier: OK ($lignes_fichier).\033[0m"
  else
    echo -e "\033[1;31m❌ $fichier: KO ($lignes_fichier vs $lignes_fichier_clean).\033[0m"
  fi
done