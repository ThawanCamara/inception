# Base image
FROM debian:bullseye

# Adding metadata
LABEL maintainer="tde-souz" version="1.0"
LABEL description="My custom MariaDB image"

# Installation
RUN apt update \
&& apt install -y mariadb-server

RUN mariadb-install-db --user=mysql --basedir=/usr --datadir=/database

# Set environment variables


# Copy files into container
COPY conf/maria-server.cnf /etc/mysql/mariadb.conf.d/maria-server.cnf
COPY ./tools/create-db.sh /bin

HEALTHCHECK --interval=10s --timeout=3s \
	CMD mysqladmin ping -u root || exit 1

# Default command
ENTRYPOINT ["sh", "/bin/create-db.sh"]
