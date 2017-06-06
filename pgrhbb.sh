#!/bin/bash

echo create new basebackup ..

systemctl stop pghoard.service
rm -R /var/lib/pghoard/metadata/pokus-main-local/
rm -R /var/lib/pghoard/backups/pokus-main-local/
systemctl start pghoard.service

echo finished.
