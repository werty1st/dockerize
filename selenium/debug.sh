#!/bin/bash


PORTL=4444          #docker's exposed port maps inside container
NAME=selenium_debug	#container name and portforwad name
VM_NAME=default     #docker machine vm name


#docker run --rm -p 4444:4444 -p 5900:5900 --name selenium_debug selenium/standalone-chrome-debug
#Debug
#sudo docker run -d -p 4444:4444 -p 5900:5900 --name selenium_debug selenium/standalone-chrome-debug:2.48.2
#VNC
#password: secret
#vncviewer localhost

#When you are prompted for the password it is secret. If you wish to change this then you should either change it in the /NodeBase/Dockerfile and build the images yourself, or you can define a docker image that derives from the posted ones which reconfigures it:
#FROM selenium/node-chrome-debug:2.53.0
#RUN x11vnc -storepasswd <your-password-here> /home/seluser/.vnc/passwd

#CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                    NAMES
#48edbb3c2d36        selenium/standalone-chrome   "/opt/bin/entry_point"   3 seconds ago       Up 2 seconds        0.0.0.0:4444->4444/tcp   selenium


#test mit 