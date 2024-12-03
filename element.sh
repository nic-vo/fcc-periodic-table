#!/bin/bash

PSQL="psql -U freecodecamp -d periodic_table -t --no-align -c"

PRINT_ELEMENT() {
  if [[ $1 ]]
  then
    echo "$1" | while IFS="|" read NUMBER NAME SYMBOL TYPE MASS MELT BOIL
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  else
    echo "Improperly formatted element to display."
  fi
}

NOT_FOUND() {
  echo -e "I could not find that element in the database."
}

if [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT="$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1")"
  if [[ $ELEMENT ]]
  then
    PRINT_ELEMENT "$ELEMENT"
  else
    NOT_FOUND
  fi
elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
then
  ELEMENT="$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")"
  if [[ $ELEMENT ]]
  then
    PRINT_ELEMENT "$ELEMENT"
  else
    NOT_FOUND
  fi
elif [[ $1 =~ ^[a-zA-Z]{3,}$ ]]
then
  ELEMENT="$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$1'")"
  if [[ $ELEMENT ]]
  then
    PRINT_ELEMENT "$ELEMENT"
  else
    NOT_FOUND
  fi
else
  echo "Please provide an element as an argument."
fi
