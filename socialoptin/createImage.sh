#!/bin/bash

PORTL=8081         #docker's exposed port maps inside container
NAME=optin_service #container name and portforwad name
VM_NAME=default    #docker machine vm name


#docker run --name optin_live -d -p 8282:80 optin
#get latest version
git clone --depth 1 -b master https://github.com/werty1st/socialoptin socialoptin
docker build -t optin .

#remove all cotainers based on optin
docker ps -a | awk '{ print $1,$2 }' | grep optin | awk '{print $1 }' | xargs -I {} docker rm -f {}


#remove all cotainers based on image "optin"
#docker ps --format '{{.ID}}\t{{.Image}}' | awk '{ print $1,$2 }' | grep "optin" | awk '{print $1 }' | xargs -I {} docker rm -f {}

#remove all cotainers based on name "optin_service"
docker ps --format '{{.ID}}\t{{.Names}}' | awk '{ print $1,$2 }' | grep "$NAME" | awk '{print $1 }' | xargs -I {} docker rm -f {}

#start container
docker run -d -p $PORTL:80 --restart=always --name="$NAME" optin

#Rulename, localPort, guestPort, $2, $5, $7
#VBoxManage showvminfo $VM_NAME --machinereadable | awk -F '[",]' '/^Forwarding/ { printf ("Rule %s host port %d forwards to guest port %d\n", $2, $5, $7); }'
natrules=($(VBoxManage showvminfo "$VM_NAME" --machinereadable | awk -F '[",]' '/^Forwarding/ { printf ("%s,%s,%s\n", $2, $5, $7); }'))

pos=0
for i in "${natrules[@]}"
do
    #split line to array
    IFS=',' read -r -a array <<< $i
    
    #array to var
    name=${array[0]}
    local=${array[1]}
    remote=${array[2]}
    
    #find conflict portmap
    if [ "$local" -eq "$PORTL" ]
    then
        echo "existing portmapping found"
        echo "Name: ${array[0]} Local: ${array[1]} Remote: ${array[2]}"

        #remove portmap #todo ask user
        if [ ! -z $(vboxmanage list runningvms | awk '{print $1}' | grep \"$VM_NAME\") ]
        then
            VBoxManage controlvm "$VM_NAME" natpf1 delete "$name"
        else
            VBoxManage modifyvm "$VM_NAME" natpf1 delete "$name"
        fi

        echo "existing nat rule removed"
    fi
    #echo "Name: ${array[0]} Local: ${array[1]} Remote: ${array[2]}"
    (( pos++ ))
done

echo "add nat rule"

if [ ! -z $(vboxmanage list runningvms | awk '{print $1}' | grep \"$VM_NAME\") ]
then
    VBoxManage controlvm "$VM_NAME" natpf1 "$NAME,tcp,127.0.0.1,$PORTL,,$PORTL"
else
    VBoxManage modifyvm "$VM_NAME" natpf1 "$NAME,tcp,127.0.0.1,$PORTL,,$PORTL"
fi

#show result
xdg-open http://localhost:$PORTL
