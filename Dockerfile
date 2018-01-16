FROM marceloweb/php70-fpm-alpine:1.0
MAINTAINER <marcelo@marceloweb.info>

RUN set -ex \
        && ( \
                docker-php-ext-install mysqli pdo pdo_mysql \
        ) \
        && ( \
                apk add \
                        --no-cache \
                        freetype \
                        libpng \
                        libjpeg-turbo \
                        freetype-dev \
                        libpng-dev \
                        libjpeg-turbo-dev\
                && docker-php-ext-configure gd \
                        --with-gd \
                        --with-freetype-dir=/usr/include/ \
                        --with-png-dir=/usr/include/ \
                        --with-jpeg-dir=/usr/include/ \

                && docker-php-ext-install gd \
                && apk del \
                        --no-cache \
                        freetype-dev \
                        libpng-dev \
                        libjpeg-turbo-dev \
        ) \
        ## install mcrypt
        && ( \
                apk add \
                        --no-cache \
                        libmcrypt-dev \
                        libltdl \
                && docker-php-ext-configure mcrypt \
                        --with-mcrypt \
                && docker-php-ext-install mcrypt \
        )
	
ENTRYPOINT ["docker-php-entrypoint"]       

EXPOSE 9000
CMD ["php-fpm"] 
