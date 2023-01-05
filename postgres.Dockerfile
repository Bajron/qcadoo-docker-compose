FROM postgres:15
# jdbc driver incompatibility, requires md5
# With scram-sha-256 (default in the recent Postgres), application stops with messages like "The authentication type 10 is not supported."
# Could be solved with newer jdbc 
CMD ["-c", "password_encryption=md5"]
ENV POSTGRES_INITDB_ARGS=--auth-host=md5

# Database initialization
RUN mkdir -p /docker-entrypoint-initdb.d
COPY --from=qcadoo:local /opt/qcadoo/mes-application/webapps/ROOT/WEB-INF/classes/schema/demo_db_pl.sql \
    /docker-entrypoint-initdb.d/001_demo_db_pl.sql

# Not needed acutally (for the md5 and scram-sha-256 problem), initdb option does the trick
# COPY pg_init/reset_password.sh \
#     /docker-entrypoint-initdb.d/002_reset_password.sh
