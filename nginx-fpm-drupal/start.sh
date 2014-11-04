#!/bin/bash
# start all the services
function setEnvironmentVariable() {
if [ -z "$2" ]; then
echo "Environment variable '$1' not set."
return
fi
# echo "Environment variable '$1' set to '$2'."
# Check whether variable already exists
if grep -q $1 /etc/php5/fpm/pool.d/www.conf; then
# Reset variable
sed -i "s/^env\[$1.*/env[$1] = $2/g" /etc/php5/fpm/pool.d/www.conf
else
# Add variable
echo "env[$1] = $2" >> /etc/php5/fpm/pool.d/www.conf
fi
}

for _curVar in `env | grep DRUPAL_ | awk -F = '{print $1}'`;do
# awk has split them by the equals sign
# Pass the name and value to our function
# echo "For '${_curVar}' - '${!_curVar}'"
setEnvironmentVariable ${_curVar} ${!_curVar}
done

mkdir /var/cache/nginx/
chown -R www-data:www-data /var/cache/nginx/
chown -R www-data:www-data /usr/share/nginx/html
/usr/local/bin/supervisord -n
