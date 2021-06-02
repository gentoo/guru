# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 udev

DESCRIPTION="Library and command line tool for interacting with hardware wallets"
HOMEPAGE="https://github.com/bitcoin-core/HWI"

MY_PN="HWI"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/bitcoin-core/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="udev doc"

BDEPEND=""
RDEPEND="
	>=dev-python/bitbox02-5.3.0[${PYTHON_USEDEP}]
	>=dev-python/ecdsa-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/hidapi-0.7.99[${PYTHON_USEDEP}]
	>=dev-python/libusb1-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/mnemonic-0.18.0[${PYTHON_USEDEP}]
	>=dev-python/pyaes-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4.1[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# remove upper bounds on dependencies from setup.py file
	sed 's/,<[0-9.]\+//' -i setup.py || die "sed failed"

	pushd test
	# remove tests that require hardware emulation
	rm test_coldcard.py test_device.py test_digitalbitbox.py test_keepkey.py test_ledger.py test_trezor.py
	# remove udev tests because it expects the rules are installed in the libs folder
	rm test_udevrules.py
	popd

	distutils-r1_python_prepare_all
}

python_install_all() {
	use udev && udev_dorules hwilib/udev/*.rules
	use doc  && dodoc -r docs

	distutils-r1_python_install_all
}
