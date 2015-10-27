#!/bin/bash

sudo docker run -d -p 4444:4444 --name selenium selenium/standalone-chrome

#CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                    NAMES
#48edbb3c2d36        selenium/standalone-chrome   "/opt/bin/entry_point"   3 seconds ago       Up 2 seconds        0.0.0.0:4444->4444/tcp   selenium
