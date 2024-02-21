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

machine_name="docker"
if [ ! -z $USER ]; then
    machine_name=$USER
else
    machine_name=$USERNAME
fi

# Si option --create
if  [ "$1" == "--create" ]; then
    
    nb_machines=1
    [ ! -z "$2" ] && nb_machines=$2
    # idmax=$(docker ps -a --format {{.Names}} | grep $USERNAME-alpine |  awk -F '-' '{print $3}' | sort -r | head -1)
    idmax=$(docker ps -a --format {{.Names}} |  awk -F '-' -v user=$machine_name '$0 ~ user"-alpine" {print $3}' | sort -r | head -1)
    
    # Definition varibale min et max
    min=0
    max=0

    [ -z $idmax ] && idmax=0 
    min=$((idmax+1))
    max=$((min+nb_machines-1))

    echo "############################################"
    echo "#      Debut création des containeurs      #"
    echo "############################################"
    echo ""
    #for i in $(seq 1 $nb_machines); do
    for i in $(seq $min $max); do
        docker run -tid --name "$machine_name-alpine-$i" alpine:latest
        echo "Container $machine_name-alpine-$i crée"
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
       # docker stop $i
       docker rm -f $i
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
