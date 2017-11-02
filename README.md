kafka-docker
============
Simple Kafka docker image

## Kafka
v1.0.0

## Environments
* KAFKA_VERSION, default 1.0.0
* SCALA_VERSION, default 2.11
* KAFKA_HOME, default /opt/kafka
* KAFKA_PORT, default 9092
* KAFKA_ZOOKEEPER_CONNECT, default localhost:2181

## How to Use
Example:

`docker run --rm \
-e KAFKA_ZOOKEEPER_CONNECT=zookeeper.local:2181 \
-p 9092:9092 \
wrohandi/kafka:1.0.0`

