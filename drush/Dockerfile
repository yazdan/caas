FROM    debian:latest
MAINTAINER Abbas Yazdanpanah <abyz@outlook.com>
RUN apt-get update
#RUN apt-get -y upgrade

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl

# Basic Requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client curl vim php5-cli php5-mysql 

RUN apt-get clean

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer global require drush/drush:6.*
RUN ln -s /root/.composer/vendor/drush/drush/drush /usr/bin/drush


