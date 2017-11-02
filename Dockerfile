FROM phusion/baseimage:0.9.22
MAINTAINER Wira Rohandi <wira@rohandi.com>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install wget unzip jq openjdk-8-jdk -y

ARG kafka_version=1.0.0
ARG scala_version=2.11

ENV KAFKA_VERSION=$kafka_version SCALA_VERSION=$scala_version
ENV KAFKA_HOME=/opt/kafka
ENV KAFKA_PORT=9092
ENV KAFKA_ZOOKEEPER_CONNECT=localhost:2181


ENV PATH ${PATH}:${KAFKA_HOME}/bin

# Download Kafka
ADD download-kafka.sh /tmp/download-kafka.sh
RUN chmod a+x /tmp/download-kafka.sh && \
    sync && \
    /tmp/download-kafka.sh && \
    tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
    rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka


ADD start-kafka.sh /usr/bin/start-kafka.sh

# The scripts need to have executable permission
RUN chmod a+x /usr/bin/start-kafka.sh

# Clean up
RUN apt-get clean


# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]