# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 linux-info udev

COMMIT="ebf9965192196feaae6828bc41bf3dac1d9a1e5e"
DESCRIPTION="ASUS ROG userspace mouse driver for Linux."
HOMEPAGE="https://github.com/kyokenn/rogdrv"
S="${WORKDIR}/${PN}-${COMMIT}"
SRC_URI="https://github.com/kyokenn/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/python-evdev[${PYTHON_USEDEP}]
		dev-python/cffi[${PYTHON_USEDEP}]
		dev-python/hidapi[${PYTHON_USEDEP}]
		dev-libs/libappindicator
		virtual/udev"
RDEPEND="${DEPEND}"
CONFIG_CHECK="~INPUT_UINPUT"

python_prepare_all() {
	# duplicate text, commited to upstream
	sed -i -e '/Comment=ASUS/d' rogdrv.desktop rogdrv/gtk3.py || die
	# udev rules are placed outside /usr
	sed -i -e '/etc[\/]udev/d' setup.py || die
	# clear setup_requires, for some reason this package
	# triggers something in setuptools that calls pip
	sed -i -e '/setup_requires/,+2d' setup.py || die
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
