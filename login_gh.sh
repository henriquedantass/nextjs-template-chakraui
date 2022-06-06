#!/bin/bash

# verifica se existe uma autenticação no gh válida
verifyAuthStatus () {
  status=1

  (gh auth status) > /dev/null 2>&1 && status=0
  
  if [ $status == 0 ]; then
  echo "Você já está autenticado com o token gh válido!" && return 0
  else createAuth
  fi

}

# função para criar uma autenticação no gh com um token válido
createAuth () {
   createAuthStatus=1  

   echo "Você não está autenticado para utilizar os comandos gh."
   echo "Por favor insira um token de acesso pessoal o qual você pode criar em https://github.com/settings/tokens"
   read GITHUB_TOKEN
   set -u
   echo "$GITHUB_TOKEN" > .githubtoken
   unset GITHUB_TOKEN

   (gh auth login --with-token < .githubtoken) > /dev/null 2>&1 && createAuthStatus=0

   rm .githubtoken

   if [ $createAuthStatus == 0 ]; then
   echo "Autenticação realizada com sucesso!" && return 0
   else echo "Autenticação falhou, digite um token válido, ou então adicione em $HOME/.config/gh um diretório contendo o token em yaml" && return 1
   fi

}

verifyAuthStatus
