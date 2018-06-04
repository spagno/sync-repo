#!/bin/bash
if [ -e .sync.sh.md5 ]
then
	sync_old=$(cat .sync.sh.md5)
else
	sync_old=""
fi
sync_new=$(md5sum sync.sh)
if [ -z "$sync_old" ]
then
	echo "First time, have to build"
	./build.sh
else
	sync_new=$(md5sum sync.sh)
	if [ "$sync_new" == "$sync_old" ]
	then
		echo "NO BUILD"
	else
		echo "FILE sync.sh changed, have to build"
		./build.sh
	fi
fi
echo "$sync_new" > .sync.sh.md5
docker run -t --rm -v $HOME/RPM-repos:/repos \
	-e rh_user=$rh_user \
	-e rh_pass=$rh_pass \
	-e rh_pool=$rh_pool miticojo/reposync:latest
