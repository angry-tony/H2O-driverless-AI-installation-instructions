#!/bin/bash
# launch h2o.ai locally
# mounts the data/log/license directories from /var/lib/h2o-driverless-ai
# publishes to port 3001

# cannot use this with nvidia-modprobe failing with no GPU
# set -e

ROOT=/var/lib/h2o-driverless-ai
RUNNER=nvidia-docker

# the below will exit with non-0 if no gpu
nvidia-modprobe
if [ $? -eq 1 ]; then
  echo "no gpu found"
  RUNNER=docker
fi

echo "launch on port 3001. Check http://ip:3001"
$RUNNER run \
  --rm \
  -u `id -u`:`id -g` \
  -p 3001:12345 \
  -v $ROOT/data:/data \
  -v $ROOT/log:/log \
  -v $ROOT/license:/license \
   opsh2oai/h2oai-runtime
