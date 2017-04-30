#§/bin/bash

cd $(dirname $0)/..
mkdir -p data
URL=http://www.parti-socialiste.fr/liste-candidats-aux-legislatives-investis-ps/
echo "département,circonscription,nom" > data/investitures-deputes-PS-2017.csv
curl -sL $URL                                           |
  sed 's/collapseomatic_content ">/\n/g'                |
   sed "s/\&rsquo;/'/g"                                 |
  grep -P "Département | \(\d+\)| circonscription :"    |
  while read line; do
    if echo $line | grep "circonscription" > /dev/null; then
      circo=$(echo $line | sed -r 's/^[^0-9]+//' | sed -r 's/^([0-9]+)è.*$/\1/')
      nom=$(echo $line | sed 's/^.* :\s*//' | sed 's/\s*<\/a[^>]*>.*</</' | sed 's/\s*<a[^>]*>\s*//g' | sed 's/\s*<.*$//' | sed 's/^[ \s]\+//')
      echo "$dep,$circo,$nom"
    else
      dep=$(echo $line | sed -r 's/^.*(Département | \()([0-9]+)[^0-9].*$/\2/')
    fi
  done | sort -n >> data/investitures-deputes-PS-2017.csv

