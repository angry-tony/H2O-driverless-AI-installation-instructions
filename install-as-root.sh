# script that needs to be used with sudo to run
# e.g. wget https://gist.github.com/shadiakiki1986/71f49c4051b68a2a9d6e449b62d00a8e/raw/install-as-root.sh -O -|sudo /bin/sh
# Note: permalink from
# https://gist.github.com/atenni/5604615
######################################################################################################################################################################

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