podman stop container_python_1
podman rm container_python_1
podman rmi image_python_1

cd /home/pi32/Code/pi32/python

uid=1001
gid=1002
subuidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
subgidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))
   
podman build \
-f Dockerfile \
-t image_python_1 .

##-v /HOST-DIR:/CONTAINER-DIR

podman run -dt \
--name container_python_1 \
--pod pod_main \
--user $uid:$gid \
-v /home/pi32/Code/pi32/python:/workdir \
localhost/image_python_1:latest

##--user $uid:$gid \
## -v /opt/dmtools/code/dmtoolv1/:/workdir \
#podman build \
#--build-arg=ENV_UID=${ENV_UID} \
#-t image_mariadb_1 .
#--user $uid:$gid \
#-v /home/pi32/Code/pi32/python/:/workdir \
