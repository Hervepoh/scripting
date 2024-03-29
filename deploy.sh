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
    
    # Definition varibale min & max
    min=0
    max=0
    
    # Recuperation de idmax
    # idmax=$(docker ps -a --format {{.Names}} | grep $USERNAME-alpine |  awk -F '-' '{print $3}' | sort -r | head -1)
    idmax=$(docker ps -a --format {{.Names}} |  awk -F '-' -v user=$machine_name '$0 ~ user"-alpine" {print $3}' | sort -r | head -1)
    [ -z $idmax ] && idmax=0 

    # redefinition de min & max
    min=$((idmax+1))
    max=$((idmax+nb_machines))

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
    echo -e "\n############################################"
    echo "#      Restart existing containeurs        #"
    echo -e "############################################\n"
 
    # docker container restart $(docker ps -a --format "{{ .Names }}" | awk '$0 ~ "herve.ngando-alpine" { print $0 }')
    docker start $(docker ps -a | grep $machine_name-alpine | awk '{print $1}') 
   
    echo -e "\n############################################"
    echo "#      Existing containeurs restart        #"
    echo -e "############################################\n"
    
# Si option --ansible
elif  [ "$1" == "--ansible" ]; then
    echo ""
    echo " Notre option est --ansible"
    echo ""

# Si option --infos
elif  [ "$1" == "--infos" ]; then

    echo -e "\n############################################"
    echo "#      Informations sur les containeurs        #"
    echo -e "############################################\n"
    # Information sur les containeurs
    for docker_id in $(docker ps | grep $machine_name-alpine | awk '{print $1}'); do
        # docker inspect --format "{{.Name}} . {{.NetworkSettings.IPAddress }}" $docker_id
        docker inspect -f " => {{.Name}} : {{.NetworkSettings.IPAddress }} " $docker_id
    done

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


# $?  test  si le command est ok retoune 0 sinon retourne 1
