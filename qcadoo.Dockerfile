FROM ubuntu:20.04
RUN apt-get update
RUN apt-get -y --no-install-recommends install openjdk-8-jdk wget unzip
RUN mkdir -p /opt/qcadoo && \
    cd tmp && \
    wget https://github.com/qcadoo/mes/releases/download/2.4.1/qcadoo-mes-2.4.1.zip && \
    unzip qcadoo-mes-2.4.1.zip && \
    mv mes-application /opt/qcadoo/
RUN cp /opt/qcadoo/mes-application/bin/startup.sh /opt/qcadoo/mes-application/bin/run.sh  && \
    sed -i '$s/ start / run /' /opt/qcadoo/mes-application/bin/run.sh
COPY ./secrets/postgres-passwd /opt/qcadoo/mes-application/conf
RUN sed -ri \
    -e "s/dbPassword=postgres123/dbPassword=$( head -n 1 /opt/qcadoo/mes-application/conf/postgres-passwd )/" \
    -e 's%dbJdbcUrl=.*%dbJdbcUrl=jdbc:postgresql://db:5432/mes%' \
    /opt/qcadoo/mes-application/qcadoo/db.properties
ENTRYPOINT [ "/opt/qcadoo/mes-application/bin/run.sh" ]