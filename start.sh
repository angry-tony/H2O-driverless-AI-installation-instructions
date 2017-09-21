#  mounts the data/log/license directories from /var/lib/h2o-driverless-ai
# publishes to port 3001
#######################################################################################################

# add user to docker group
sudo gpasswd -a $USER docker
newgrp docker
docker run hello-world

# launch
# If GPU is not used, replace nvidia-docker with docker
export ROOT=/var/lib/h2o-driverless-ai
nvidia-docker run \
  --rm \
  -u `id -u`:`id -g` \
  -p 3001:12345 \
  -v $ROOT/data:/data \
  -v $ROOT/log:/log \
  -v $ROOT/license:/license \
  opsh2oai/h2oai-runtime
  