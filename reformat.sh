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

Q_ECHO "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;"
Q_ECHO "ALTER TABLE properties ALTER COLUMN melting_point SET NOT NULL;"
Q_ECHO "ALTER TABLE properties ALTER COLUMN boiling_point SET NOT NULL;"
Q_ECHO "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;"
Q_ECHO "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;"
Q_ECHO "ALTER TABLE elements ADD CONSTRAINT element_name_unique UNIQUE (name);"
Q_ECHO "ALTER TABLE elements ADD CONSTRAINT element_symbol_unique UNIQUE (symbol);"
Q_ECHO "ALTER TABLE elements ALTER COLUMN name SET NOT NULL;"
Q_ECHO "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;"
Q_ECHO "ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);"
Q_ECHO "CREATE TABLE types(type_id SERIAL PRIMARY KEY);"
Q_ECHO "ALTER TABLE types ADD COLUMN type VARCHAR(15) NOT NULL;"
Q_ECHO "INSERT INTO types(type) VALUES('metal'),('metalloid'),('nonmetal');"
Q_ECHO "ALTER TABLE properties ADD COLUMN type_id INT;"
Q_ECHO "UPDATE properties SET type_id=1 WHERE type='metal';"
Q_ECHO "UPDATE properties SET type_id=2 WHERE type='metalloid';"
Q_ECHO "UPDATE properties SET type_id=3 WHERE type='nonmetal';"
Q_ECHO "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;"
Q_ECHO "ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id);"
Q_ECHO "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;"
Q_ECHO "ALTER TABLE properties DROP COLUMN type;