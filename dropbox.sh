# Note 1: At the step of installing dropbox, open link displayed in screen to link your dropbox account
# for convenience, link the driverless AI folders to a dropbox folder
#############################

# install requirements for dropbox headless for convenience to upload files into driverless AI
# https://www.dropbox.com/install-linux
apt-get -qq -y install \
    python
wget https://www.dropbox.com/download?dl=packages/dropbox.py -O /usr/bin/dropbox
chmod +x /usr/bin/dropbox

# mount a volume from /dev/xvdf into /mnt/ec2vol
# and put the dropbox folder there
# to format a new volume: mkfs -t ext4 /dev/xvdf
mkdir /mnt/ec2vol
mount /dev/xvdf /mnt/ec2vol
chown ubuntu:ubuntu /mnt/ec2vol -R

# This is where the prompt in Note 1 will show up
# move dropbox folder to /mnt/ec2vol
dropbox start -i && dropbox stop
mv ~/Dropbox /mnt/ec2vol/Dropbox
ln -s /mnt/ec2vol/Dropbox ~/Dropbox

# check status downloading
sleep 10 && dropbox status

/mnt/ec2vol/Dropbox/Shadi_Datasets/driverless-ai-dir$ mkdir log license
