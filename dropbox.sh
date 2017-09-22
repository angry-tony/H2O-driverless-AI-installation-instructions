# Note 1: At the step of installing dropbox, open link displayed in screen to link your dropbox account
# for convenience, link the driverless AI folders to a dropbox folder
# This script is not meant to be run automatically in one shot
# Instead, run it manually one step at a time, modifying steps as needed
#############################

# install requirements for dropbox headless for convenience to upload files into driverless AI
# https://www.dropbox.com/install-linux
sudo apt-get -qq -y install \
    python
sudo wget https://www.dropbox.com/download?dl=packages/dropbox.py -O /usr/bin/dropbox
sudo chmod +x /usr/bin/dropbox

# mount a volume from /dev/xvdf into /mnt/ec2vol
# and put the dropbox folder there
# to format a new volume: mkfs -t ext4 /dev/xvdf
sudo mkdir /mnt/ec2vol
sudo mount /dev/xvdf /mnt/ec2vol
sudo chown ubuntu:ubuntu /mnt/ec2vol -R

# This is where the prompt in Note 1 will show up
# move dropbox folder to /mnt/ec2vol
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd # manually click the link, when done linking the account, press Ctrl+C to terminate
dropbox start
watch dropbox status # wait till it starts syncing, then do dropbox stop
mv ~/Dropbox /mnt/ec2vol/Dropbox
ln -s /mnt/ec2vol/Dropbox ~/Dropbox

# At this step, make sure no files get "deleted" by dropbox unintentionally
# If it happens, log into the web interface, click "show deleted files", select them, and click "restore"
dropbox start 

# link the dropbox folder to the /var/lib/h2o-driverless-ai folder that will be mount into the docker image
mkdir ~/Dropbox/Shadi_Datasets/h2o-driverless-ai/{mkdir,log,license}
cd /var/lib
sudo mv driverless-ai-dir driverless-ai-dir.bkp
sudo ln -s ~/Dropbox/Shadi_Datasets/h2o-driverless-ai/ .
cd -
