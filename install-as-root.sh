# script that needs to be used with sudo to run
##################################################

# install docker
# prepend h2o's documentation with getting the docker's official gpg key
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#os-requirements
apt-get remove docker docker-engine docker.io
apt-get update
apt-get install \
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
apt-get update
apt-get install docker-ce
docker run hello-world