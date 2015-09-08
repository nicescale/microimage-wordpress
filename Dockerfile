FROM microimages/php-apache

WORKDIR /app

VOLUME /app

ENV WORDPRESS_VERSION 4.3

RUN apk add --update tar
RUN wget -O wordpress.tar.gz https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
	&& tar -xzf wordpress.tar.gz --strip-components=1 \
	&& rm wordpress.tar.gz \
	&& chown -R nobody:nobody /app

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
