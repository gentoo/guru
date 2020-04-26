# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 eutils toolchain-funcs

DESCRIPTION="Python library to interact with keepass databases (supports KDBX3 and KDBX4) "
HOMEPAGE="https://github.com/libkeepass/pykeepass"
SRC_URI="https://github.com/libkeepass/pykeepass/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/lxml-4.3.4
	>=dev-python/pycryptodome-3.8.2
	>=dev-python/construct-2.9.45
	>=dev-python/argon2_cffi-19.1.0
	>=dev-python/python-dateutil-2.8.0
	>=dev-python/future-0.17.0"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/0001-setup.py-exclude-tests-directory.patch" )

python_test() {
	"${EPYTHON}" tests/tests.py -v || die
}
