#!/bin/bash
docker run -t --rm -v $HOME/RPM-repos:/repos \
	-e rh_user=$rh_user \
	-e rh_pass=$rh_pass \
	-e rh_pool=$rh_pool miticojo/reposync:latest
