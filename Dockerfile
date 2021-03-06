FROM microimages/php-apache

WORKDIR /app

ENV WORDPRESS_VERSION 4.4.2

RUN apk add --update tar sed

RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
	&& tar -xzf /tmp/wordpress.tar.gz -C /app/ --strip-components=1 \
	&& rm /tmp/wordpress.tar.gz \
	&& chown -R nobody:nobody /app

VOLUME /app

COPY docker-entrypoint.sh /entrypoint.sh

#ENTRYPOINT ["/entrypoint.sh"]

CMD ["/entrypoint.sh", "apache2-foreground"]
