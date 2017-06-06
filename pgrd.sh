#!/bin/bash

echo stop services ..

pg_ctlcluster 9.5 main stop > /var/log/mz/pgrd 2>&1
systemctl stop pghoard.service


echo remove cluster and backup ..

sudo -u postgres rm -R /var/lib/pghoard/backups/pokus-main-local/ > /var/log/mz/pgrd 2>&1
sudo -u postgres rm -R /var/lib/pghoard/metadata/pokus-main-local/ > /var/log/mz/pgrd 2>&1
rm -R /var/lib/postgresql/9.5/main/ > /var/log/mz/pgrd 2>&1


echo build cluster and restore ..

pg_dropcluster 9.5 main > /var/log/mz/pgrd 2>&1
pg_createcluster 9.5 main > /var/log/mz/pgrd 2>&1
cp /var/lib/postgresql/pgdump/*.conf /etc/postgresql/9.5/main/
pg_ctlcluster 9.5 main start > /var/log/mz/pgrd 2>&1

sudo -u postgres psql -p 5433 -c "\i /var/lib/postgresql/pgdump/globals.sql" > /var/log/mz/pgrd 2>&1
sudo -u postgres pg_restore -C -d template1 /var/lib/postgresql/pgdump/codex2020 > /var/log/mz/pgrd 2>&1

echo start services ..
systemctl start pghoard.service > /var/log/mz/pgrd 2>&1

echo
pg_lsclusters
echo pghoard.service:
systemctl status pghoard.service | grep Active: