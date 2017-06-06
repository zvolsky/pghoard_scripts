#!/bin/bash

leafpad /var/lib/pghoard/pghoard.json
cp /var/lib/pghoard/pghoard.json /var/lib/postgresql/pgdump/bk/
