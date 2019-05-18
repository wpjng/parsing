#!/bin/bash
if [[ $1 == "" || $2 == "" ]]; then # verifica se os dois argumentos estão preenchidos
  echo "Modo de uso do script."
  echo "./parsing.sh alvo.com.br hostsvivos.txt"
  exit
else
  mkdir /tmp/parsing/
  c=0 # criar variavel para fazer o loagind bonitinho
  echo -ne "Parsing" # opção -ne para nao utilizar o \n "quebra de linha"
  while [ $c -lt 20 ]; do #loading bonitinho
    echo -ne "."
    sleep 0.06
    c=$(($c+1))
  done
  wget $1 -O /tmp/parsing/index.html #baixa o "alvo"

  awk -F '"' '/href/ {print $2}'  /tmp/parsing/index.html | grep "http" | cut -d "/" -f 3 | sort -u >> /tmp/parsing/hosts.txt
  for h in $(cat /tmp/parsing/hosts.txt); do
    host $h >> $2
    rm -rf /tmp/index.html
  done
  for n in $(cat /tmp/parsing/hosts.txt); do
    wget $n -O /tmp/parsing/.index.html

    awk -F '"' '/href/ {print $2}'  /tmp/parsing/index.html | grep "http" | cut -d "/" -f 3 | sort -u >> /tmp/parsing/hosts.txt
    for h in $(cat /tmp/parsing/hosts.txt); do
      host $h >> $2
      rm -rf /tmp/index.html
    done

  done
fi
rm -rf /tmp/parsing/index.html
rm -rf /tmp/parsing/hosts.txt
exit
