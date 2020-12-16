FROM ubuntu:bionic

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install requirements
RUN apt-get update && apt-get install -y nginx php \
						php-fpm php-cli php-mysql \
						php-zip php-gd php-mbstring \
						php-curl php-xml php-pear php-bcmath \
						supervisor
						
# copy files
RUN cd ~ && mkdir YOURLS 
WORKDIR ~/YOURLS
COPY . .
COPY ./docker/yourls.conf /etc/nginx/conf.d/

# define envs
ENV YOURLS_DB_HOST localhost
ENV YOURLS_DB_USER root
ENV YOURLS_DB_PASS fjkle!#AUY
ENV YOURLS_DB_NAME yourls
ENV YOURLS_DB_PREFIX yourls_

ENV YOURLS_SITE localhost
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

# expose port
EXPOSE 80

# chown
RUN chown -R www-data:www-data ~/YOURLS

# CMD ["/bin/sh","-c","while true; do echo hello; sleep 10;done"]
CMD ["./docker/setup.sh"]