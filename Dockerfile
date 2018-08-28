FROM tianon/centos:6.5
MAINTAINER honeyshawn

ADD Centos-Source.repo /etc/yum.repos.d/Centos-Source.repo

# rpm数据库损坏需要重建,因此需要在 “yum install …” 前使用 “rpm –rebuilddb” 重建数据库
RUN rpm --rebuilddb \
    && yum update -y \
    && yum install -y tar bzip2 yum-utils rpm-build

RUN rpm --rebuilddb \
    && yum-builddep -y pam \
    && yumdownloader --source pam \
    && rpmbuild --rebuild  --define 'WITH_AUDIT 0' --define 'dist +noaudit' pam*.src.rpm \
    && rpm -Uvh --oldpackage ~/rpmbuild/RPMS/*/pam*+noaudit*.rpm

RUN rm -f /*.rpm && rm -rf ~/rpmbuild