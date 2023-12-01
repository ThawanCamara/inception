FROM debian:bullseye

#ENV WP_DOMAIN=${WP_DOMAIN}

RUN apt update -y \
&& apt upgrade \
&& apt install php-fpm php-mysql -y \
&& apt install wget -y \
&& apt install mariadb-client -y

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /tmp/wp-cli.phar
RUN mv /tmp/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY ./tools/wp-install.sh /usr/local/bin
#RUN	mkdir -p /var/www/html/${WP_DOMAIN}
#COPY	./tools/wp-config.php /var/www/html/${WP_DOMAIN}/wp-config.php

ENTRYPOINT ["sh", "/usr/local/bin/wp-install.sh"]
