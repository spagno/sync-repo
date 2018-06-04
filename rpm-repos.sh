#!/bin/bash
docker rm -f rpm-repos
docker run -d --name rpm-repos -p 8000:8043 -v ${HOME}/RPM-repos:/srv/http --restart always --read-only pierrezemb/gostatic
