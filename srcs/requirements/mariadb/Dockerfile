FROM	debian:bullseye		

COPY	./tools/varfix.sh /etc/mysql/varfix.sh
COPY	./tools/init.sql /etc/mysql/init.sql
COPY	./conf/my.cnf /etc/mysql/my.cnf

RUN	chmod +x /etc/mysql/varfix.sh && /etc/mysql/varfix.sh

RUN	apt update && \
	apt-get install -y mariadb-server mariadb-client && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /var/run/mysqld &&\
	chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

RUN	mariadb-install-db --user=mysql --basedir=/usr --datadir=/database

EXPOSE 3306

CMD ["mysqld", "--init-file=/etc/mysql/init.sql"]


