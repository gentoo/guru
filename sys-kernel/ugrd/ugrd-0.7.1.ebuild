# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} pypy3 )
inherit distutils-r1

DESCRIPTION="Python based initramfs generator with TOML defintions"
HOMEPAGE="https://github.com/desultory/ugrd"
SRC_URI="https://github.com/desultory/${PN}/archive/refs/tags/${PV}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE="cryptsetup btrfs -gpg -zfs"

RDEPEND="app-misc/pax-utils
cryptsetup? ( sys-fs/cryptsetup )
btrfs? ( sys-fs/btrfs-progs )
gpg? ( app-crypt/gnupg )
zfs? ( sys-fs/zfs )"
DEPEND=""
BDEPEND=""
