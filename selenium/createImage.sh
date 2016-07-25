#!/bin/bash


PORTL=4444          #docker's exposed port maps inside container
NAME=selenium 		#container name and portforwad name
VM_NAME=default     #docker machine vm name



#remove all cotainers based on image "selenium/standalone-chrome"
docker ps --format '{{.ID}}\t{{.Image}}' | awk '{ print $1,$2 }' | grep "selenium/standalone-chrome" | awk '{print $1 }' | xargs -I {} docker rm -f {}

#remove all cotainers based on name "selenium"
#docker ps --format '{{.ID}}\t{{.Names}}' | awk '{ print $1,$2 }' | grep "$NAME" | awk '{print $1 }' | xargs -I {} docker rm -f {}

docker run -d -p $PORTL:4444 --restart=always --name="$NAME" selenium/standalone-chrome
