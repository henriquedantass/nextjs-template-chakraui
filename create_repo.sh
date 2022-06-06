#!/bin/bash

if [[ "$(docker images -q gh-repo:latest 2> /dev/null)" == "" ]]; then
  docker build -t gh-container -f dockerfiles/GH-Dockerfile .
  docker build -t gh-repo -f dockerfiles/CreateRepo-Dockerfile .
fi

checkAuthStatus () {
  authStatus=1  

  (docker run --rm -it -v ${HOME}:/root gh-container "auth" "status") > /dev/null 2>&1 && authStatus=0

  if [ $authStatus == 0 ]; then
    echo "Você está autenticado!"
    createRepo
  else 
    echo "É necessário autenticar" 
    docker run --rm -it -v ${HOME}:/root gh-container
  fi
}

createRepo () {
    echo "criando repositório"
    docker run --rm -it -v ${HOME}:/root gh-repo "bash" "create_repo.sh"
}



checkAuthStatus