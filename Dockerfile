FROM alpine:3.15.4 AS base

ARG MVN_VERSION=3.8.5
ARG OPENMRS_REPO=https://github.com/openmrs/openmrs-core.git
ARG OPENMRS_VERSION=master

RUN apk update && apk add openjdk16
RUN wget -P /tmp https://dlcdn.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz && \
      tar xzf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz -C /usr/local/lib/ && \
      ln -s /usr/local/lib/apache-maven-${MVN_VERSION}/bin/* /usr/local/bin/

RUN mvn -version

RUN addgroup -g 1000 -S openmrs && \
    adduser -u 1000 -S openmrs -G openmrs -h /openmrs

FROM base AS dev

RUN apk add git vim

USER openmrs
WORKDIR /openmrs