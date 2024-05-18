#! /usr/bin/env bash
# Maintainer: Andrew Ammerlaan <andrewammerlaan@gentoo.org>
#
# Fetch and setup the latest ::gentoo

sudo mkdir -p /var/db/repos/gentoo /etc/portage /var/cache/distfiles
wget -qO - "https://github.com/gentoo-mirror/gentoo/archive/master.tar.gz" | sudo tar xz -C /var/db/repos/gentoo --strip-components=1
sudo wget "https://www.gentoo.org/dtd/metadata.dtd" -O /var/cache/distfiles/metadata.dtd
sudo wget "https://gitweb.gentoo.org/proj/portage.git/plain/cnf/repos.conf" -O /etc/portage/repos.conf
sudo ln -s /var/db/repos/gentoo/profiles/default/linux/amd64/17.1 /etc/portage/make.profile
