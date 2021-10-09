# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8,9} pypy3 )
inherit distutils-r1

DESCRIPTION="Python low level port I/O for Linux x86"
HOMEPAGE="
	http://portio.inrim.it
	https://pypi.org/project/portio
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( index.rst )

src_prepare() {
	sed -e '/include_dirs/d' \
		-e '/library_dirs/d' \
		-i setup.py || die

	distutils-r1_src_prepare
}
