# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="PyFtdi provides a user-space driver for FTDI devices"
HOMEPAGE="https://github.com/eblot/pyftdi"
SRC_URI="https://github.com/eblot/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

BDEPEND="
	test? (
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	)
"

python_test() {
	FTDI_LOGLEVEL=WARNING
	FTDI_DEBUG=on
	FTDI_VIRTUAL=off "${EPYTHON}" pyftdi/tests/mockusb.py || die
	FTDI_VIRTUAL=on "${EPYTHON}" pyftdi/tests/gpio.py || die
	FTDI_VIRTUAL=on "${EPYTHON}" pyftdi/tests/eeprom_mock.py || die
}
