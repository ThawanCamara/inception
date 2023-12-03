FROM debian:bullseye

RUN apt update \
&& apt install -y mariadb-server

RUN mariadb-install-db --user=mysql --basedir=/usr --datadir=/database

COPY conf/my.cnf    /etc/mysql/mariadb.conf.d/my.cnf
COPY ./tools/create-db.sh /bin

ENTRYPOINT ["sh", "/bin/create-db.sh"]
