# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 linux-info udev

COMMIT="4bdb41403d2000ae8941bc987f5a2dbafedbc544"
DESCRIPTION="ASUS ROG userspace mouse driver for Linux."
HOMEPAGE="https://github.com/kyokenn/rogdrv"
S="${WORKDIR}/${PN}-${COMMIT}"
SRC_URI="https://github.com/kyokenn/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libappindicator
		dev-python/python-evdev
		dev-python/cffi
		dev-python/cython-hidapi
		virtual/udev"
RDEPEND="${DEPEND}"
BDEPEND=""
CONFIG_CHECK="~INPUT_UINPUT"

python_prepare_all() {
	# duplicate text, commited to upstream
	sed -i -e '/Comment=ASUS/d' rogdrv.desktop rogdrv/gtk3.py
	# udev rules are placed outside /usr
	sed -i -e '/etc[\/]udev/d' setup.py
	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install
	udev_dorules udev/50-rogdrv.rules
}

pkg_postinst() {
	elog "Reconnect your mouse to get your mouse working with the new rules."
	elog "See the README file for usage instructions."
	udev_reload
}
