#!/bin/bash

leafpad /var/lib/postgresql/pgdump/postgresql.conf
cp /var/lib/postgresql/pgdump/postgresql.conf /var/lib/postgresql/pgdump/bk/
cp /var/lib/postgresql/pgdump/postgresql.conf /etc/postgresql/9.5/main/
