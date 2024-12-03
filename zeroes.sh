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

MASSES="$($PSQL "SELECT atomic_mass FROM properties")"

echo "$MASSES" | while read HAS_ZEROES
do
  PARSED="$(echo "$HAS_ZEROES" | sed -r 's/0+$//g' | sed -r 's/\.$//')"
  Q_ECHO "UPDATE properties SET atomic_mass=$PARSED WHERE atomic_mass=$HAS_ZEROES"
done