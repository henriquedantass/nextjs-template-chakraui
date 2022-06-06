#!/bin/bash

. clone_template.sh


if [[ "$(docker images -q gh-container:latest 2> /dev/null)" == "" ]]; then
  docker build -t gh-container -f .d3-lib/dockerfiles/GH-Dockerfile .
  docker build -t gh-login -f .d3-lib/dockerfiles/LoginGh-Dockerfile .
fi

checkAuthStatus () {
  authStatus=1  

  (docker run --rm -it -v ${HOME}:/root gh-container "auth" "status") > /dev/null 2>&1 && authStatus=0

  if [ $authStatus == 0 ]; then
    echo "Você está autenticado!" && return 0
  else 
    echo "É necessário autenticar" 
    docker run --rm -it -v ${HOME}:/root gh-login
  fi
}



createRepo () {
    echo "criando repositório"

    clone_template.sh
}



checkAuthStatus