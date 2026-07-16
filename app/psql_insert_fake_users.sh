#!/bin/bash

STR_HOST=postgres
STR_PORT=5432
STR_DB=mydb
STR_USER=admin
read -sp "Enter Password: " STR_PASS

python3 psql_create_fake_users.py

echo "${STR_HOST}:${STR_PORT}:${STR_DB}:${STR_USER}:${STR_PASS}" > ~/.pgpass
chmod 0600 ~/.pgpass

echo "PSQL Setup tb_users Table"
psql -h ${STR_HOST} -U ${STR_USER} -d ${STR_DB} -f setup_tb_users.sql

echo "PSQL Insert Fake Users from File"
psql -h ${STR_HOST} -U ${STR_USER} -d ${STR_DB} -c "\copy tb_users(first_name, last_name, date_of_birth, email, gender) FROM '/app/fake_users.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',')"

echo "PSQL RUN PL/PSQL Function"
psql -h ${STR_HOST} -U ${STR_USER} -d ${STR_DB} -c "SELECT import_csv_and_loop_insert()"

# DELETING PASSWORD
# rm -v ~/.pgpass # Verbosed
rm  ~/.pgpass
if [[ $? -eq 0 ]]; then
    echo "Done"
fi