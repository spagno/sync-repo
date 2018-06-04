#/bin/bash

#docker build -t miticojo/simple-http-server:latest simple-http-server/
#[[ $(docker ps -f "name=repo" --format '{{.Names}}') == 'repo' ]] ||
#docker run -d --rm --volume ~/rpms:/webserver --name repo miticojo/simple-http-server:latest

#REPO_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rpm-repos`
REPO_IP="repo.nodisk.space"
REPO_URL=https://${REPO_IP}

docker build --no-cache --build-arg repo_url=${REPO_URL} -t miticojo/reposync:latest . 

#docker rm -f repo
