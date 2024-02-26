#!/bin/bash

##############################################################################
# 
#  Description : deploiement à la volée de conteneur docker
#
#  Auteur      : Herve 
#
#  Date        : 19/02/2024
#
##############################################################################

# Exercices 1 : les notes       # débutant

# Écrire un script qui demande à l'utilisateur de saisir une note et qui affiche un message en fonction de cette note :
# "très bien" si la note est entre 16 et 20
# "bien" lorsqu'elle est entre 14 et 16
# "assez bien" si la note est entre 12 et 14
# "moyen" si la note est entre 10 et 12
# "insuffisant" si la note est inférieur à 10

echo "Saisir une note"
read note

if (( $note >= 16 )); then
   echo "très bien"
elif (( $note >= 14 )) && (( $note < 16 )); then
   echo "bien"
elif (( $note >= 12 )) && (( $note < 14 )); then
   echo "assez bien"
elif (( $note >= 10 )); then
   echo "moyen"
else
    echo "insuffisant"
fi