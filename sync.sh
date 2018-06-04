#!/bin/bash

trap ctrl_c INT

function ctrl_c() {
       subscription-manager unregister
}

([ -z "$rh_user" ] && [ -z "$rh_pass" ] && [ -z "$rh_pool" ]) && \
   echo "missing variable rh_user, rh_pass and rh_pool" && exit 3

[ ! -e /repos ] && \
  echo "missing folder /repos" && exit 3

[ -d /etc/rhsm-host ] && rm -f /etc/rhsm-host

subscription-manager register --username $rh_user --password $rh_pass
REG=$?

[ "$REG" != "0" ] && echo "Registration error" && exit 3

# Get Employee Subscription pool
employee_id=$(subscription-manager list --available --matches 'Employee SKU' --pool-only | head -n 1)
subscription-manager attach --pool=$employee_id
# Get Satellite 6.3 pool
satellite_id=$(subscription-manager list --available --matches 'Red Hat Satellite' --pool-only | head -n 1)
subscription-manager attach --pool=$satellite_id
subscription-manager repos --disable=*

for f in $(find /repos -maxdepth 1 -type d ! -path /repos | awk -F/ '{print $3}');
do
   reposync -r $f -l -d -n -p /repos/
   SYNC=$?
   [ "$SYNC" == "0" ] && createrepo --update -d --skip-stat /repos/$f
done

subscription-manager unregister && subscription-manager clean

exit 0
