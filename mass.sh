#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align -c"

cat ../atomic_mass.txt | while IFS="|" read NUMBER MASS 
do
  echo $MASS
  if [[ $MASS != 'atomic_mass' ]]
  then 
  UPDATE_MASS=$($PSQL "UPDATE properties SET atomic_mass = atomic_mass::REAL where atomic_number=$NUMBER")
  echo $UPDATE_MASS
  fi
done
