FROM postgres:11

COPY ./create-multiple-databases.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/create-multiple-databases.sh