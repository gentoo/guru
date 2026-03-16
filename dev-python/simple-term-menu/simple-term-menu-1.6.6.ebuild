# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A Python package which creates simple interactive menus on the command line"
HOMEPAGE="
	https://github.com/IngoMeyer441/simple-term-menu
	https://pypi.org/project/simple-term-menu/
"
SRC_URI="https://github.com/IngoMeyer441/simple-term-menu/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests import-check

src_install() {
	distutils-r1_src_install

	dodoc LICENSE
}
