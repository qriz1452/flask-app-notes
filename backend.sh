#!/bin/bash
export PATH=/bin:/usr/bin:/opt/aws/bin:$PATH
export PYTHONPATH="${PYTHONPATH}:/usr/local/lib/python2.7/site-packages/"
echo 'Gy2B&(k5' | passwd cloud_user --stdin
yum install -y epel-release wget
wget -O /tmp/aws-cfn-bootstrap-latest.amzn1.noarch.rpm https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.amzn1.noarch.rpm
yum install -y /tmp/aws-cfn-bootstrap-latest.amzn1.noarch.rpm
yum update -y
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y git docker-ce
usermod -aG docker cloud_user
systemctl enable --now docker
docker pull postgres:12.1-alpine
git clone https://github.com/linuxacademy/content-intro-to-python-development/ /tmp/python
cd /tmp/python
git checkout remotes/origin/use-case-web-app
cp -r notes /home/cloud_user/notes
cat > /home/cloud_user/notes/.env <<EOF
export DB_HOST='notesdb'
export DB_PORT='5432'
export DB_NAME='notes'
export DB_USERNAME='demo'
export DB_PASSWORD='secure_password'
export FLASK_ENV='development'
export FLASK_APP='.'
EOF
source /home/cloud_user/notes/.env
docker network create notes
docker run -d --name notesdb --network notes -p $DB_PORT:5432 -e POSTGRES_USER=$DB_USERNAME -e POSTGRES_PASSWORD=$DB_PASSWORD --restart always postgres:12.1-alpine
sed -ri '/python_version/d' /home/cloud_user/notes/Pipfile*
sed -i 's/postgres/postgresql/g' /home/cloud_user/notes/config.py
rm -rf /home/cloud_user/notes/migrations
chown -R cloud_user: /home/cloud_user/notes
docker pull python:3
docker exec -i notesdb psql postgres -U $DB_USERNAME -c 'CREATE DATABASE notes;'
