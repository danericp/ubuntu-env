#!/bin/bash

INT_USERS=${FAKE_USERS_COUNT}
STR_HOST=${DB_HOST}
STR_PORT=${DB_PORT}
STR_DB=${DB_NAME}
STR_USER=$(cat /run/secrets/db_user)

read -sp "Enter Password (Default is \"secret\"): " STR_PASS

python3 psql_create_fake_users.py

echo "${STR_HOST}:${STR_PORT}:${STR_DB}:${STR_USER}:${STR_PASS}" > ~/.pgpass
chmod 0600 ~/.pgpass

echo "PSQL Setup tb_users Table"
psql -h ${STR_HOST} -U ${STR_USER} -d ${STR_DB} -f setup_tb_users.sql

echo "PSQL Insert Fake Users from File"
psql -h ${STR_HOST} -U ${STR_USER} -d ${STR_DB} -c "\copy tb_users(first_name, last_name, date_of_birth, email, gender) FROM '/app/fake_users.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',')"

echo "PSQL RUN PL/PSQL Function"
psql -h ${STR_HOST} -U ${STR_USER} -d ${STR_DB} -c "SELECT import_csv_and_loop_insert()"

echo "PSQL Test Heredocs"
psql -A -F "|" -h ${STR_HOST} -d ${STR_DB} -t -U ${STR_USER} > output.txt << 'EOF'
SELECT first_name, last_name
FROM tb_users
WHERE gender = 'm'
ORDER BY date_of_birth DESC;
EOF

rm  ~/.pgpass
if [[ $? -eq 0 ]]; then
    echo "Done"
fi