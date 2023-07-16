#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align -c"

$PSQL "select * from elements" | while IFS="|" read ID SYMBOL NAME 
do
  if [[ $NAME != "name" ]]
  then
  echo $ID
  CAPITALIZE_SYMBOL=$($PSQL "update elements set symbol = INITCAP(symbol) where atomic_number = $ID")
  echo "Changing capitalization to element: $NAME"
  echo $CAPITALIZE_SYMBOL
  fi
done
