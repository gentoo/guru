# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Client library for Ledger Bitcoin application"
HOMEPAGE="
	https://pypi.org/project/ledger-bitcoin/
	https://github.com/LedgerHQ/app-bitcoin-new
"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64"
# Tests require Speculos emulator, that cannot be packaged due to a dependency
# on dev-libs/openssl:0/1.1
# https://github.com/LedgerHQ/speculos/issues/447
RESTRICT="test"

RDEPEND="
	>=dev-python/ledgercomm-1.1.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

python_prepare_all() {
	# not used here and in revdeps
	sed -i 's/from smartcard.*/raise ImportError/' \
	ledger_bitcoin/btchip/btchipComm.py || die

	# don't try using the Speculos emulator
	sed -i 's/from speculos.*/raise ImportError/' \
	ledger_bitcoin/client_base.py || die

	distutils-r1_python_prepare_all
}
