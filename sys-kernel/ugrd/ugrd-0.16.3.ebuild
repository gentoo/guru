# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
inherit distutils-r1 optfeature

DESCRIPTION="Python based initramfs generator with TOML defintions"
HOMEPAGE="https://github.com/desultory/ugrd"
SRC_URI="https://github.com/desultory/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-misc/pax-utils"
DEPEND=">=dev-python/zenlib-1.2.0
	>=dev-python/pycpio-0.7.0
	sys-apps/pciutils"

src_install() {
	# Call the distutils-r1_src_install function to install the package
	distutils-r1_src_install
	# Create the ugrd config directory
	keepdir /etc/ugrd
	# Install the example config into /etc/ugrd/config.toml
	# Do not overwrite an existing config
	insinto /etc/ugrd
	newins examples/example.toml config.toml
	# Create the kernel preinst.d directory if it doesn't exist
	# Install the kernel preinst.d hook
	keepdir /etc/kernel/preinst.d
	exeinto /etc/kernel/preinst.d
	doexe hooks/51-ugrd.install
}

pkg_postinst() {
	optfeature "ugrd.crypto.cryptsetup support" sys-fs/cryptsetup
	optfeature "ugrd.fs.btrfs support" sys-fs/btrfs-progs
	optfeature "ugrd.crypto.gpg support" app-crypt/gnupg
}
