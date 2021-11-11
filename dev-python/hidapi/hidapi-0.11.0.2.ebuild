# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
DISTUTILS_USE_SETUPTOOLS="rdepend"
inherit distutils-r1

DESCRIPTION="A Cython interface to the hidapi"
HOMEPAGE="https://github.com/trezor/cython-hidapi"
MY_PV=$(ver_rs 3 .post)
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="|| ( BSD GPL-3 )"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
SLOT="0"

DEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-libs/hidapi
"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
S="${WORKDIR}/${PN}-${MY_PV}"

python_configure_all() {
	DISTUTILS_ARGS=( --with-system-hidapi )
}

python_test() {
	epytest tests.py
}
