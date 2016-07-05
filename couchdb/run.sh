#!/bin/bash

sudo docker pull klaemo/couchdb:latest

# expose it to the world on port 5984 and use your current directory as the CouchDB Database directory
sudo docker run --rm -d -p 5984:5984 -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=s00fa -v $(pwd)/db_files:/usr/local/var/lib/couchdb --name couchdb klaemo/couchdb

docker run -d -p 5984:5984 -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=pass --name couchdb klaemo/couchdb


#funktioniert nicht. fehlt die DB
docker export couchdb > nightmanager_couchdb_container.tar
cat nightmanager_couchdb_container.tar | docker import --change "ENV COUCHDB_USER admin" --change "ENV COUCHDB_PASSWORD pass" - couchdb:nightmanager
docker run -d -p 5984:5984 -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=pass -v /usr/local/var/lib/couchdb --name couchdb couchdb:nightmanager couchdb

#änderungen speichern
docker commit -a "adams.r@zdf.de" -m "added couchapp" 7f8706a21825 couchdb:nightmanager
sha256:efd3aafeec99ed70ec3646e56ddba12e4737dfa6a33e23901822e7268973fcab

#neues image exportieren
docker save couchdb:nightmanager > nightmanager_couchdb_image.tar

#image laden
docker load < nightmanager_couchdb_image.tar

#image starten
docker run -d -p 5984:5984 -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=pass --name couchdb couchdb:nightmanager

#hilft alles nichts. die daten werden in einem anonymen container gespeichert der beim start nach /usr/local/var/lib/couchdb gemounted wird.



#neuer ansatz data only container
docker create -v /usr/local/var/lib/couchdb --name nightmanager klaemo/couchdb /bin/true
docker run -d -p 5984:5984 -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=pass --volumes-from nightmanager --name couchdb klaemo/couchdb

#bringt auch nicht weil man die daten dann wieer mühselig sicher und importieren muss

#zurück auf start
docker run --rm -d -p 5984:5984 -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=pass -v $(pwd)/db_files:/usr/local/var/lib/couchdb --name couchdb klaemo/couchdb