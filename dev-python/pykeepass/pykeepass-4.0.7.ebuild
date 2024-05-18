# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python library to interact with keepass databases (supports KDBX3 and KDBX4) "
HOMEPAGE="https://github.com/libkeepass/pykeepass"
SRC_URI="https://github.com/libkeepass/pykeepass/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/argon2-cffi-19.2.0[${PYTHON_USEDEP}]
	>=dev-python/construct-2.10.54[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.3.5[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.8.2[${PYTHON_USEDEP}]
	test? ( >=dev-python/pyotp-2.9.0[${PYTHON_USEDEP}] )
"
distutils_enable_tests unittest

src_prepare() {
	# their package listing was skipping the subpackage
	sed -i '/packages =/d' pyproject.toml || die
	distutils-r1_src_prepare
	# pycryptodomex to pycryptodome conversion
	sed -i 's/Cryptodome/Crypto/g' pykeepass/kdbx_parsing/{common,twofish}.py || die
}

python_test() {
	"${EPYTHON}" tests/tests.py -v || die
}
