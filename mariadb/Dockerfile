#docker run --detach
#--name some-mariadb
#--env MARIADB_USER=example-user
#--env MARIADB_PASSWORD=my_cool_secret
#--env MARIADB_ROOT_PASSWORD=my-secret-pw  
#mariadb:latest

#podman build \
#--build-arg=BUILD_ENV_UID=${ENV_UID} \
#--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
#--build-arg=BUILD_ENV_GID=${ENV_GID} \
#--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
#--build-arg=BUILD_ENV_MARIADB_USER=${ENV_MARIADB_USER} \
#--build-arg=BUILD_ENV_MARIADB_PASSWORD=${ENV_MARIADB_PASSWORD} \
#--build-arg=BUILD_ENV_MARIADB_ROOT_PASSWORD=${ENV_MARIADB_ROOT_PASSWORD} \
#--build-arg=BUILD_ENV_MARIADB_DATABASE=${ENV_MARIADB_DATABASE} \
#-t mariadb_1 .

FROM mariadb:10.9

#ARG name
#ENV env_name $name

ARG BUILD_ENV_USERNAME
ARG BUILD_ENV_UID
ARG BUILD_ENV_GID 
ARG BUILD_ENV_GROUPNAME

ARG BUILD_ENV_MARIADB_USER
ARG BUILD_ENV_MARIADB_PASSWORD
ARG BUILD_ENV_MARIADB_ROOT_PASSWORD
ARG BUILD_ENV_MARIADB_DATABASE

###

ENV ENV_USERNAME=$BUILD_ENV_USERNAME
ENV ENV_USER_UID=$BUILD_ENV_UID
ENV ENV_USER_GID=$BUILD_ENV_GID 
ENV ENV_USER_GROUPNAME=$BUILD_ENV_GROUPNAME

ENV ENV_MARIADB_USER=$BUILD_ENV_MARIADB_USER
ENV ENV_MARIADB_PASSWORD=$BUILD_ENV_MARIADB_PASSWORD
ENV ENV_MARIADB_ROOT_PASSWORD=$BUILD_ENV_MARIADB_ROOT_PASSWORD
ENV ENV_MARIADB_DATABASE=$BUILD_ENV_MARIADB_DATABASE

#ENV env_name $name


RUN apt-get update && apt-get -y install vim
RUN apt-get -y install unzip

#RUN echo ${ENV_UID}

# Create the user
RUN echo groupadd --gid ${ENV_USER_GID} ${ENV_USER_GROUPNAME}
RUN groupadd --gid ${ENV_USER_GID} ${ENV_USER_GROUPNAME}
RUN echo useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}
RUN useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}

#RUN chown $USER_UID:$USER_GID /docker-entrypoint-initdb.d
RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /var/lib/mysql

#ADD sql/ /docker-entrypoint-initdb.d

#ENV MYSQL_ROOT_PASSWORD test123
#ENV MYSQL_DATABASE testDB
#ENV MYSQL_USER toto
#ENV MYSQL_PASSWORD test123

COPY world-db.zip /var/www/html/world-db.zip
RUN unzip -j /var/www/html/world-db.zip -d /docker-entrypoint-initdb.d

#RUN unzip -j /var/www/html/world-db.zip -d /

### COPY x_backup.sql /docker-entrypoint-initdb.d

#unzip -j /path/to/file.zip -d other_folder

#RUN rm /var/www/html/world-db.zip

COPY init.sql /docker-entrypoint-initdb.d/init.sql

run echo ${ENV_USERNAME}

RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /docker-entrypoint-initdb.d/

USER ${ENV_USERNAME}

env MARIADB_USER=${ENV_MARIADB_USER}
env MARIADB_PASSWORD=${ENV_MARIADB_PASSWORD}
env MARIADB_ROOT_PASSWORD=${ENV_MARIADB_ROOT_PASSWORD}
env MARIADB_DATABASE=${ENV_MARIADB_DATABASE}

EXPOSE 3306

CMD ["mysqld"]

