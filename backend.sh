#!/bin/bash
sudo export PATH=/bin:/usr/bin:/opt/aws/bin:$PATH
sudo export PYTHONPATH="${PYTHONPATH}:/usr/local/lib/python2.7/site-packages/"

sudo docker pull postgres:12.1-alpine

sudo cat > ./.env <<EOF
export DB_HOST='notesdb'
export DB_PORT='5432'
export DB_NAME='notes'
export DB_USERNAME='demo'
export DB_PASSWORD='secure_password'
export FLASK_ENV='development'
export FLASK_APP='.'
EOF
sudo source ./.env
sudo docker network create notes
sudo docker run -d --name notesdb --network notes -p $DB_PORT:5432 -e POSTGRES_USER=$DB_USERNAME -e POSTGRES_PASSWORD=$DB_PASSWORD --restart always postgres:12.1-alpine

sudo sed -ri '/python_version/d' ./Pipfile*
sudo sed -i 's/postgres/postgresql/g' ./config.py

sudo docker pull python:3
sudo docker exec -i notesdb psql postgres -U $DB_USERNAME -c 'CREATE DATABASE notes;'
