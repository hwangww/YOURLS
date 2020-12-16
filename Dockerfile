FROM ubuntu:bionic

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install requirements
RUN apt-get update && apt-get install -y nginx php \
						php-fpm php-cli php-mysql \
						php-zip php-gd php-mbstring \
						php-curl php-xml php-pear php-bcmath \
						supervisor
		
RUN useradd -m --uid 1000 --gid 50 docker		
RUN echo export APACHE_RUN_USER=docker >> /etc/apache2/envvars
RUN echo export APACHE_RUN_GROUP=staff >> /etc/apache2/envvars

COPY docker/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY . /var/www/html
RUN a2enmod rewrite

WORKDIR /var/www/html
RUN chown -R docker /var/www/html

############ INITIAL APPLICATION SETUP #####################

WORKDIR /var/www/html

# define envs
ENV YOURLS_DB_HOST localhost
ENV YOURLS_DB_USER root
ENV YOURLS_DB_PASS fjkle!#AUY
ENV YOURLS_DB_NAME yourls
ENV YOURLS_DB_PREFIX yourls_

ENV YOURLS_HOURS_OFFSET -5
ENV YOURLS_PRIVATE true
ENV YOURLS_UNIQUE_URLS true

ENV YOURLS_COOKIEKEY qQ4KhL_pu|s@Zm7n#%:b^{A[vhm
ENV USER admin
ENV PASSWORD admin
ENV YOURLS_URL_CONVERT 62
ENV YOURLS_PRIVATE_INFOS true
ENV YOURLS_PRIVATE_API true
ENV YOURLS_NOSTATS false

EXPOSE 80


USER root

COPY docker/supervisor-exit-event-listener /usr/bin/supervisor-exit-event-listener
RUN chmod +x docker/setup.sh /usr/bin/supervisor-exit-event-listener

# CMD ["/bin/sh","-c","while true; do echo hello; sleep 10;done"]
CMD ["./docker/setup.sh"]