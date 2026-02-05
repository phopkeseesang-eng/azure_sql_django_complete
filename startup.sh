#!/bin/bash

# คำสั่งพวกนี้ Azure จะเป็นคนรันเอง คุณไม่ต้องรันเอง
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql18
ACCEPT_EULA=Y apt-get install -y unixodbc-dev

python manage.py migrate
gunicorn --bind=0.0.0.0 --timeout 600 azure_project.wsgi