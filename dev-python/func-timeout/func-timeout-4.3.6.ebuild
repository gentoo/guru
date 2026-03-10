# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python module which allows you to specify timeouts for any function"
HOMEPAGE="https://github.com/kata198/func_timeout"
SRC_URI="https://github.com/kata198/func_timeout/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/func_timeout-${PV}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_prepare() {
	rm func_timeout/py2_raise.py || die

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install

	dodoc LICENSE
}
