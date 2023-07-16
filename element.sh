#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align -t -c"

if [[ -z $1 ]]
then 
  echo -e "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    FETCH_ELEMENT=$($PSQL "select * from elements as e inner join properties as p using (atomic_number) inner join types using (type_id) where e.atomic_number = $1 LIMIT 1")
  else
    FETCH_ELEMENT=$($PSQL "select * from elements as e inner join properties as p using (atomic_number) inner join types using (type_id) where e.name = '$1' or e.symbol = '$1' LIMIT 1")
  fi
  if [[ -z $FETCH_ELEMENT ]]
  then
    echo -e "I could not find that element in the database."
  else
    echo $FETCH_ELEMENT | while IFS="|" read TYPEID ATOMIC_NUMBER SYMBOL NAME MASS MELTING BOILING TYPE
    do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
fi

