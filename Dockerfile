FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y curl openjdk-8-jdk \
    && echo "deb http://packages.cloud.google.com/apt cloud-sdk-xenial main" |  tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add - \
    &&  apt-get update &&  apt-get install -y google-cloud-sdk \
    &&  apt-get install -y kubectl

RUN mkdir -p /home/jenkins/slave \
    && mkdir -p /usr/share/jenkins

RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > /tmp/get_helm.sh \
    && chmod 700 /tmp/get_helm.sh \
    && ./tmp/get_helm.sh

COPY jenkins-slave /usr/local/bin/jenkins-slave
COPY agent.jar /usr/share/jenkins/agent.jar

ENTRYPOINT ["jenkins-slave"]
