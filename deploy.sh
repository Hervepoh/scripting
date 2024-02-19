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

# echo "Nb de parametres : " $#
# echo "Nom du fichier : " $0
# echo "Liste des parametres: " $*
# echo "Liste des parametres dans un tableau " $@

id_machines="docker"
if [ ! -z $USER ]; then
    id_machines=$USER
else
    id_machines=$USERNAME
fi

# Si option --create
if  [ "$1" == "--create" ]; then
    
    nb_machines=1
    [ $2=="" ] && nb_machines=$2
    
    echo "############################################"
    echo "#      Debut création des containeurs      #"
    echo "############################################"
    echo ""
    for i in $(seq 1 $nb_machines); do
        docker run -tid --name "$id_machines-alpine-$i" alpine:latest
        echo "Container $id_machines-alpine-$i crée"
        echo "-------------------------------"
    done 
    echo ""
    echo "############################################"
    echo "#        Fin création des containeurs      #"
    echo "############################################"


# Si option --drop
elif  [ "$1" == "--drop" ]; then
    echo "############################################"
    echo "#    Debut suppression des containeurs     #"
    echo "############################################"
    echo ""

    ids=$(docker ps -a | grep $USERNAME-alpine | awk '{print $1}')
    # echo $ids
    for i in $ids; do
       # echo $i
       docker stop $i
       docker rm $i
    done

    echo ""
    echo "############################################"
    echo "#     Fin suppression des containeurs      #"
    echo "############################################"


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
