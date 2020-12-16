#!/bin/bash

config_file="/var/www/html/user/config.php"
template="/var/www/html/user/config-sample.php"
#cp /~/YOURLS/user/config-sample.php /~/YOURLS/user/config.php
if [ ! -x "$config_file" ]; then
        cp $template $config_file		
		sed -i "s/\$YOURLS_DB_HOST/$YOURLS_DB_HOST/g" $config_file
		sed -i "s/\$YOURLS_DB_USER/$YOURLS_DB_USER/g" $config_file
		sed -i "s/\$YOURLS_DB_PASS/$YOURLS_DB_PASS/g" $config_file
		sed -i "s/\$YOURLS_DB_NAME/$YOURLS_DB_NAME/g" $config_file
		sed -i "s/\$YOURLS_DB_PREFIX/$YOURLS_DB_PREFIX/g" $config_file
		sed -i "s/\$YOURLS_SITE/$YOURLS_SITE/g" $config_file
		sed -i "s/\$YOURLS_HOURS_OFFSET/$YOURLS_HOURS_OFFSET/g" $config_file
		sed -i "s/\$YOURLS_PRIVATE/$YOURLS_PRIVATE/g" $config_file
		sed -i "s/\$YOURLS_UNIQUE_URLS/$YOURLS_UNIQUE_URLS/g" $config_file
		sed -i "s/\$YOURLS_COOKIEKEY/$YOURLS_COOKIEKEY/g" $config_file
		sed -i "s/\$USER/$USER/g" $config_file
		sed -i "s/\$PASSWORD/$PASSWORD/g" $config_file
		sed -i "s/\$YOURLS_URL_CONVERT/$YOURLS_URL_CONVERT/g" $config_file
		sed -i "s/\$YOURLS_PRIVATE_INFOS/$YOURLS_PRIVATE_INFOS/g" $config_file
		sed -i "s/\$YOURLS_PRIVATE_API/$YOURLS_PRIVATE_API/g" $config_file
		sed -i "s/\$YOURLS_NOSTATS/$YOURLS_NOSTATS/g" $config_file
fi

/etc/init.d/cron start

service php7.2-fpm start
# while true; do echo hello; sleep 10;done
exec supervisord -c ./docker/supervisord.conf