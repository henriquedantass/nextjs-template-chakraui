#!/bin/bash


# Guarda os valores necessários para a criação do mfe
selected_framework=""
project_name=""
repository_name=""
mfe_type=""
port=""

configProject() {
   ## Pergunto quais as configurações básicas do projeto como nome e porta a ser utilizada.

   while [[ -z $project_name || `expr length "$project_name"` -lt 5 ]]
   do
        echo "Informe qual o nome do seu projeto(min 5 caracteres):"
        read project_name
   done

   while [[ -z $repository_name || `expr length "$repository_name"` -lt 5 ]]
   do
        echo "Agora informe um nome para o repositorio que será criado no github(min 5 caracteres):"
        read repository_name
   done

   ## Após conseguir os valores de porta e nome do projeto podemos iniciar o clone do template

   createMfe
}

createMfe() {
  ## Esses exports são necessários para substituir as variaveis dos arquivos
  export NAME="$project_name"
  export PORT="$port"

  echo "Criando repositório..."

#   gh repo create d3estudio/$repository_name --private

  echo "repositorio criado com sucesso!"

  createReactMfe
}

createReactMfe() {
  gh repo create $repository_name --private

  cd $repository_name

  cp -r ../template/* .

  envsubst < "../template/pages/index.tsx" > "pages/index.tsx"
  envsubst < "../template/package.json" > "package.json"

  echo "alterando as variaveis...."

  # Alteração das variaveis dentro dos arquivos do projeto criado
  git add .

  git commit -m "automatic create template nextjs with chakraUI"
  
  git push -u origin main

}
 
configProject

