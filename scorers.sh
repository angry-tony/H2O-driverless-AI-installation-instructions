# This is an example script of requirements for running a scorer.zip file
# exported from h2o driverless-ai
# Assumes filename is scorer.zip
#############################################

# install python3.6 requirement
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get update
sudo apt-get install python3.6 python3.6-dev

# install some openmp stuff, and fix a missing link
sudo apt-get install libomp5
sudo ln -s /usr/lib/x86_64-linux-gnu/libomp.so.5  /usr/lib/x86_64-linux-gnu/libomp.so

unzip scorer.zip # could use -d /path/to/another/folder
cd python_module

# instead of using the run_example.sh which uses virtualenv
# use pew, because pew is awesome
# https://github.com/berdario/pew
sudo pip3 install pew
pew new -r requirements.txt --python=python3.6 H2O_SCORER
python example.py