#!/bin/bash

##############################################################################
# 
#  Description : deploiement à la volée de conteneur docker
#
#  Auteur :  Herve 
#
#  Date : 16/02/2024
#
##############################################################################

# Si option --create
if  [ "$1" == "--create" ]; then
    echo ""
    echo " Notre option est --create"
    echo ""
#Si aucune option affichage de l'aide
else
    echo "
    Options :
        - --create : Lancer des containers
        - --drop : Supprimer les containers créer par le deploy.sh
        - --infos : Caracréristisques des containers (ip , nom , user,..)
        - --start : redemarrage des containers
        - --ansible : deploiement arborescence ansible
    "
fi


