podman pod stop pod_main
podman pod rm pod_main
podman rmi image_mariadb_1

cd /home/pi32/Code/pi32/mariadb

uid=${ENV_UID} ##1001
gid=${ENV_GID} ##1002

subuidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
subgidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))


podman pod create \
--name pod_main \
--network bridge \
--userns-uid-map 0:1:$uid \
--userns-uid-map  $uid:0:1 \
--userns-uid-map  $(($uid+1)):$(($uid+1)):$(($subuidSize-$uid)) \
--userns-gid-map 0:1:$gid \
--userns-gid-map $gid:0:1 \
--userns-gid-map $(($gid+1)):$(($gid+1)):$(($subgidSize-$gid)) \
--publish 3306:3306


podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
--build-arg=BUILD_ENV_MARIADB_USER=${ENV_MARIADB_USER} \
--build-arg=BUILD_ENV_MARIADB_PASSWORD=${ENV_MARIADB_PASSWORD} \
--build-arg=BUILD_ENV_MARIADB_ROOT_PASSWORD=${ENV_MARIADB_ROOT_PASSWORD} \
--build-arg=BUILD_ENV_MARIADB_DATABASE=${ENV_MARIADB_DATABASE} \
-t image_mariadb_1 .

##-v /HOST-DIR:/CONTAINER-DIR

podman run -dt \
--name container_mariadb \
--pod pod_main \
--user $uid:$gid \
--volume /home/pi32/Data/mysql:/var/lib/mysql:z \
localhost/image_mariadb_1:latest

## --user $uid:$gid \
##--volume /home/pi32/Data/mysql:/var/lib/mysql:z \
