FROM baselibrary/java:8
MAINTAINER ShawnMa <qsma@thoughtworks.com>

## Version
ENV ZOOKEEPER_MAJOR   3.4
ENV ZOOKEEPER_VERSION 3.4.5+cdh5.5.1+91-1.cdh5.5.1.p0.15~trusty-cdh5.5.1

## Repository
RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 02A818DD &&\
  echo "deb http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5 contrib" > /etc/apt/sources.list.d/cloudera.list

## Packages
RUN \
  apt-get update &&\
  apt-get install -y zookeeper=$ZOOKEEPER_VERSION zookeeper-bin &&\
  rm -rf /var/lib/apt/lists/*

## Environments
ENV PATH /usr/lib/zookeeper/bin:$PATH

## Scripts
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x            /docker-entrypoint.sh

EXPOSE 2181 2888 3888

VOLUME ["/var/lib/zookeeper"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["zkServer.sh", "start-foreground"]


