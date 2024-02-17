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
# Si option --start
elif  [ "$1" == "--start" ]; then
    echo ""
    echo " Notre option est --start"
    echo ""
# Si option --ansible
elif  [ "$1" == "--ansible" ]; then
    echo ""
    echo " Notre option est --ansible"
    echo ""
# Si option --infos
elif  [ "$1" == "--infos" ]; then
    echo ""
    echo " Notre option est --infos"
    echo ""
# Si option --drop
elif  [ "$1" == "--drop" ]; then
    echo ""
    echo " Notre option est --drop"
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

# Operateur texte []
# +-  ==  : egal
# +-  !=  : different de
# +-  !   : regation

# Operateur filesystem
# +-  -z  : variable vide
# +-  -f  : ficher existe
# +-  -d  : repertoire existe

# Operateur chiffres (())
# +-  ... tous les operateurs precedents
# +-  <= : inf ou egal
# +-  >=   : sup ou egal

# $1
# $#
# $*
# $@
# $0