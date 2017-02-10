#!/bin/bash

cd $(dirname $0)/..

bin/download.sh

if git status | grep "data/" > /dev/null; then
  if ! grep "[0-9]," data/investitures-deputes-PS-2017.csv > /dev/null ; then
    echo "WARNING: no result from http://www.parti-socialiste.fr/liste-candidats-aux-legislatives-investis-ps/"
    exit 1
  fi
  git commit data -m "autoupdate"
  git push
fi

