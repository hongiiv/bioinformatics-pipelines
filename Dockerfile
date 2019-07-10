FROM ubuntu:18.04
MAINTAINER cb.hong <cb.hong@ngenebio.com>
ENV PORT 8080
# Install apt-get
# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get install -y wget && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# GIT install
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get clean;

##RUN wget https://github.com/broadinstitute/cromwell/releases/download/43/cromwell-43.jar -P /usr/local/bin
  
ADD . /opt/cromwell
WORKDIR /opt/cromwell

COPY ./cromwell-43.jar ./
COPY ./start-cromwell-server.sh ./
COPY ./google.conf ./
COPY ./hello.wdl ./

##RUN ln -s /usr/local/bin/start-cromwell-server.sh /start-cromwell-server.sh
##RUN ln -s /usr/local/bin/cromwell-43.jar /cromwell-43.jar
##RUN ln -s /usr/local/bin/google.conf /google.conf

EXPOSE 8080
CMD ["./start-cromwell-server.sh"]

