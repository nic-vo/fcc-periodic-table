#!/bin/bash

PSQL="psql -U freecodecamp -d periodic_table -t --no-align -c"

Q_ECHO() {
  local INPUT="$1"
  if [[ -z $INPUT ]]
  then
    echo "Missing query."
  else
    echo -e "\n$INPUT:"
    echo "$($PSQL "$INPUT")"
  fi
}

Q_ECHO "INSERT INTO elements(atomic_number, name, symbol) VALUES(9, 'Fluorine', 'F'),(10, 'Neon', 'Ne');"
Q_ECHO "INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 18.998, -220, -188.1, 3),(10, 20.18, -248.6, -246.1, 3);"
Q_ECHO "DELETE FROM elements WHERE atomic_number=1000;"
Q_ECHO "DELETE FROM properties WHERE atomic_number=1000;"
