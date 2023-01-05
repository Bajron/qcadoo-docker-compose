#!/bin/bash

if !type docker docker-compose &> /dev/null
then
    sudo apt-get -y --no-install-recommends install docker.io docker-compose
fi

if !docker ps &> /dev/null
then
    sudo usermod -a -G docker $(whoami)
    echo "Please log out and log in so group assignment is applied"
    exit 1
fi

HERE=$(dirname "${0}")
mkdir -p "${HERE}/database/pgdata"

docker-compose build
exec docker-compose up
