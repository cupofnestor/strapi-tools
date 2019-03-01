#!/bin/bash
#dumps strapi metadata stored in mongoDB in specified database
#requires mongodump version >3

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -db|--database)
    DB="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--host)
    HOST="$2"
    shift # past argument
    shift # past value
    ;;
		-tgz)
    ZIP=true
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo DATABASE  = "${DB}"
echo HOST     = "${HOST}"
DATE=`date +%F`
colls=( core_store users-permissions_permission  users-permissions_role users-permissions_user)

for C in ${colls[@]}
do
  mongodump -d $DB -h $HOST -c $C
done
