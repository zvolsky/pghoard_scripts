#!/bin/bash

echo stop services ..

pg_ctlcluster 9.5 main stop  > /var/log/mz/pgrh 2>&1
systemctl stop pghoard.service


echo remove cluster ..

rm -R /var/lib/postgresql/9.5/main/  > /var/log/mz/pgrh 2>&1

echo prepare restore ..

sudo -u postgres mkdir -p /var/lib/pghoard/partials_backup/pokus-main-local/xlog_incoming/
sudo -u postgres pghoard_restore get-basebackup --config /var/lib/pghoard/pghoard.json --target-dir /var/lib/postgresql/9.5/main --restore-to-master > /var/log/mz/pgrh 2>&1
rename 's/.partial$//' /var/lib/pghoard/metadata/pokus-main-local/xlog_incoming/*.partial
cp /var/lib/pghoard/metadata/pokus-main-local/xlog_incoming/* /var/lib/pghoard/partials_backup/pokus-main-local/xlog_incoming/

systemctl start pghoard.service  > /var/log/mz/pgrh 2>&1

echo do restore ..
pg_ctlcluster 9.5 main start > /var/log/mz/pgrh 2>&1

echo
echo pghoard.service:
systemctl status pghoard.service | grep Active:
pg_lsclusters
sleep 5
pg_lsclusters

echo
echo If still in recovery, please wait - see pg_lsclusters for the state.
echo
echo After recovery check your database. If there will be problem and you decide try again:
echo  without additional action partial xlog-s will be ignored
echo  to use them copy content of /var/lib/pghoard/partials_backup/pokus-main-local/xlog_incoming/ into /var/lib/pghoard/metadata/pokus-main-local/xlog_incoming/
echo
echo If you see no problem, RUN IMMEDIATELY pgrhbb.sh TO TAKE NEW VALID BASEBACKUP
echo  and feel free to delete /var/lib/pghoard/partials_backup/.
