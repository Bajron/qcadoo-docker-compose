FROM ubuntu:20.04
RUN apt-get update
RUN apt-get -y --no-install-recommends install openjdk-8-jdk wget unzip
RUN mkdir -p /opt/qcadoo && \
    cd tmp && \
    wget https://github.com/qcadoo/mes/releases/download/2.4.1/qcadoo-mes-2.4.1.zip && \
    unzip qcadoo-mes-2.4.1.zip && \
    mv mes-application /opt/qcadoo/
ENTRYPOINT [ "/opt/qcadoo/mes-application/bin/startup.sh" ]