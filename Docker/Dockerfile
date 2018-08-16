#Create MySQL Image for JSP Tutorial Application
FROM mysql:5.7
MAINTAINER jojozhuang@gmail.com

ENV MYSQL_ROOT_PASSWORD gspassword
ADD gs_backup.sql /docker-entrypoint-initdb.d

EXPOSE 3306
