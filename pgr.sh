#!/bin/bash

pg_ctlcluster 9.5 main stop > /dev/null 2>&1
pg_ctlcluster 9.5 main start > /dev/null 2>&1

pg_lsclusters
echo pghoard.service:
systemctl status pghoard.service | grep Active: