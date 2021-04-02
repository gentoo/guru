#! /usr/bin/env bash
# Maintainer: Andrew Ammerlaan <andrewammerlaan@riseup.net>
#
# This sets up repoman and runs the latest version
#
# TODO: Force repoman to output in colour

### Setup prerequisites
python3 -m pip install --upgrade pip
pip install lxml pyyaml
sudo groupadd -g 250 portage
sudo useradd -g portage -d /var/tmp/portage -s /bin/false -u 250 portage

### Sync the portage repository
git clone https://github.com/gentoo/portage.git
cd portage

# Get all versions, and read into array
mapfile -t RM_VERSIONS < <( git tag | grep repoman | sort -u )

# Select latests version (last element in array)
RM_VERS="${RM_VERSIONS[-1]}"

# Checkout this version
git checkout tags/${RM_VERS} -b ${RM_VERS}

cd ..

### Run repoman
python3 portage/repoman/bin/repoman -dx full
