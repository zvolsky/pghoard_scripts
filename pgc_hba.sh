#!/bin/bash

leafpad /var/lib/postgresql/pgdump/pg_hba.conf
cp /var/lib/postgresql/pgdump/pg_hba.conf /var/lib/postgresql/pgdump/bk/
cp /var/lib/postgresql/pgdump/pg_hba.conf /etc/postgresql/9.5/main/
