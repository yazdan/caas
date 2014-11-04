FROM    debian:latest
MAINTAINER Abbas Yazdanpanah <abyz@outlook.com>
RUN echo "deb http://ftp.de.debian.org/debian/ wheezy-backports main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update
#RUN apt-get -y upgrade

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl

RUN DEBIAN_FRONTEND=noninteractive apt-get -t wheezy-backports -y install nginx

# Basic Requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client php5-fpm php5-mysql php-apc python-setuptools

# Drupal Requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-curl php5-gd php5-intl php-pear php5-imap

RUN apt-get clean

# nginx config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# php-fpm config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# Supervisor Config
RUN /usr/bin/easy_install supervisor
ADD ./supervisord.conf /etc/supervisord.conf


# Drupal Initialization and Startup Script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

ADD ./www.conf /etc/php5/fpm/pool.d/www.conf
ADD ./nginx/ /etc/nginx/

# private expose
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]
