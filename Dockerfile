FROM registry.access.redhat.com/rhel7.4
ARG repo_url='file:///repos'
RUN yum-config-manager --add-repo https://repo.nodisk.space/rhel-7-server-rpms && \
    yum install --nogpgcheck -y createrepo yum-utils && yum clean all && rm -f /etc/yum.repos.d/* 

WORKDIR /
RUN mkdir /repos
VOLUME /repos
ADD ./sync.sh .
CMD bash -x sync.sh
