# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

DESCRIPTION="Abstraction layer for xpyb"
HOMEPAGE="https://github.com/BurntSushi/xpybutil"
SRC_URI="https://github.com/BurntSushi/xpybutil/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz"

LICENSE="WTFPL"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/xcffib-1.5.0[${PYTHON_USEDEP}]"

python_prepare_all() {
	sed -i -e "s:share/doc/xpybutil:share/doc/xpybutil-${PV}:" setup.py || die
	distutils-r1_python_prepare_all
}
