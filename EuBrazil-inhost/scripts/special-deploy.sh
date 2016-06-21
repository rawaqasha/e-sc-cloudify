#!/bin/bash

set -e
blueprint=$1
block=$(ctx node name)
CONTAINER_ID=$2
BLOCK_NAME=$(ctx node properties block_name)
BLOCK_URL=$(ctx node properties block_Url)
LIB_DIR=$3

# Start Timestamp
STARTTIME=`date +%s.%N`

###### get task version ######
   path=${BLOCK_URL%/*}   
   ver=$(echo ${path##*/})
###### get task name without extension ######
   var=${BLOCK_NAME%.*}
   image=${var,,}
   task="$image-$ver"
#-----------------------------------------#
#----------- download the task -----------#
ctx logger info " Executing $task.jar"

sudo docker exec -it ${CONTAINER_ID} jar xf tasks/$task.jar M6CC.mao
sudo docker exec -it ${CONTAINER_ID} java -jar tasks/$task.jar ${blueprint} ${block} ${LIB_DIR}

#----------- download the task -----------#
#-----------------------------------------#


