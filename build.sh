#!/bin/sh
cd nginx-fpm-drupal
docker build -t abyz/nginx-fpm-drupal .
cd ../database
docker build -t abyz/mariadb .
cd ../drush
docker build -t abyz/drush .
