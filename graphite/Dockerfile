# This Dockerfile is used to build an image containing a ready to be used basic Graphite system.
# It includes all Graphite components for data handling (carbon-cache & carbon-aggregator) as well as the Web layer 
# (graphite-web). It comes bundled with an Apache HTTP Web server extended with mod_wsgi & mod_python. 
# All major processes inside the box are managed via 'supervisor'.

FROM ubuntu:trusty
MAINTAINER Ervin Varga <ervin.varga@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get -y update
RUN apt-get -y upgrade

# Install common stuff needed by the rest of this build file.
RUN apt-get -y install python-pip memcached python-memcache python-ldap
RUN apt-get -y install gcc

# Install the 'supervisor' process manager.
RUN apt-get -y install supervisor

# Install Apache HTTP Web server with mod_wsgi & mod_python
RUN apt-get -y install apache2 libapache2-mod-python libapache2-mod-wsgi 

# Install main Graphite components (carbon-cache, Web application & whisper) with dependencies
RUN pip install https://github.com/graphite-project/ceres/tarball/master
RUN pip install whisper
RUN apt-get -y install python-twisted python-cairo
RUN pip install carbon
RUN pip install graphite-web
RUN apt-get -y install python-django-tagging

# Configure the box. Use default Graphite configurations for everything.
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mv /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
RUN mv /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf
RUN mv /opt/graphite/conf/aggregation-rules.conf.example /opt/graphite/conf/aggregation-rules.conf
RUN mv /opt/graphite/conf/dashboard.conf.example /opt/graphite/conf/dashboard.conf
RUN mv /opt/graphite/conf/graphTemplates.conf.example /opt/graphite/conf/graphTemplates.conf
RUN mv /opt/graphite/conf/graphite.wsgi.example /opt/graphite/conf/graphite.wsgi
RUN mv /opt/graphite/webapp/graphite/local_settings.py.example /opt/graphite/webapp/graphite/local_settings.py
RUN cd /opt/graphite/webapp/graphite && echo "yes\n\nroot@example.com\nroot\nroot" | python manage.py syncdb
RUN chown -R www-data /opt/graphite/storage

RUN rm /etc/apache2/sites-available/default
ADD ./apache2.graphite-site /etc/apache2/sites-available/default

# Graphite Web application port (standard HTTP)
EXPOSE 80

# Graphite's carbon-cache ports
EXPOSE 2003 2004 7002

# Graphite's carbon-aggregator ports
EXPOSE 2023 2024

CMD ["/usr/bin/supervisord"]
