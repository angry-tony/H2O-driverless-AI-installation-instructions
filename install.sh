# Script to install driverless AI from H2O
# Usage
#        wget https://gist.github.com/shadiakiki1986/71f49c4051b68a2a9d6e449b62d00a8e/raw/install.sh -O -|sudo bash
#
# Requirements
#        needs to be used with sudo to run
#        minimum free disk space 13 GB
#        ubuntu 16 or 17
#        A dropbox account for simplifying of uploading files into driverless AI's data folder
#
# Note: permalink from https://gist.github.com/atenni/5604615
######################################################################################################################################################################

set -e
export DEBIAN_FRONTEND=noninteractive

# install docker
# prepend h2o's documentation with getting the docker's official gpg key
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#os-requirements
apt-get -qq -y remove docker docker-engine docker.io
apt-get -qq -y update
apt-get -qq -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88

# continue with h2o's documentation
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get -qq -y update
apt-get -qq -y install docker-ce
docker run hello-world

# Install nvidia-docker. Required only if GPU is used
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
dpkg -i /tmp/nvidia-docker*.deb
rm /tmp/nvidia-docker*.deb

# download the driverless ai docker image (2GB)
wget -P /tmp https://s3-us-west-2.amazonaws.com/h2o-internal-release/docker/driverless-ai-docker-runtime-rel-0.8.2.gz
# load it in docker (slow command)
sleep 1 # is this necessary for the wget to move the file to /tmp ? Not sure
docker load < /tmp/driverless-ai-docker-runtime-rel*.gz # <<< does this only work with bash and not /bin/sh?
rm /tmp/driverless-ai-docker-runtime-rel*.gz

# prepare folders
mkdir -p /var/lib/h2o-driverless-ai/{data,log,license}

# without this, the nvidia-docker run... below would fail
sudo apt-get -qq -y install nvidia-modprobe