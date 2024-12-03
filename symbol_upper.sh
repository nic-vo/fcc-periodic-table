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

SYMBOLS="$($PSQL "SELECT symbol FROM elements;")"

echo "$SYMBOLS" | while read SYMBOL
do
  UPPER_PART=$(echo "${SYMBOL:0:1}" | tr '[:lower:]' '[:upper:]')
  LOWER_PART=$(echo "${SYMBOL:1}" | tr '[:upper:]' '[:lower:]')
  Q_ECHO "UPDATE elements SET symbol='${UPPER_PART}${LOWER_PART}' WHERE symbol='$SYMBOL';"
done