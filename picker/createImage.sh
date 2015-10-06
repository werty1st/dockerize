#!/bin/bash

#docker run --name optin_live -d -p 8282:80 optin
#get latest version
git clone --depth 1 -b master https://github.com/werty1st/socialoptin socialoptin

docker build -t optin .


docker run --rm --restart=on-failure optin 