FROM centos:centos6

#Packages Install
RUN yum install -y tar php php-mysql php-pdo php-gd php-mbstring php-bcmath httpd tar

#Download and unzip Racktables
RUN curl -L -o RackTables-latest.tar.gz 'http://sourceforge.net/projects/racktables/files/latest/download?source=files'
RUN tar zxf RackTables-latest.tar.gz

#Preparing Environment
RUN cd $(find -type d -name 'RackTables-*') && rmdir /var/www/html && cp -a wwwroot /var/www/html
RUN touch /var/www/html/inc/secret.php && chmod 666 /var/www/html/inc/secret.php
ADD init.sql /usr/local/share/racktables/init.sql
ADD chsecret.sh /usr/local/share/racktables/secretfile.sh
RUN chmod +x /usr/local/share/racktables/secretfile.sh


ADD start.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start
ADD stop.sh /usr/local/bin/stop
RUN chmod +x /usr/local/bin/stop

EXPOSE 80

CMD /usr/local/bin/start && tail -F /var/log/httpd/*
