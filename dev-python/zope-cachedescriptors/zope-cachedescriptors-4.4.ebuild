# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} pypy3 )

inherit distutils-r1

DESCRIPTION="Python descriptors which cache their output"
HOMEPAGE="https://github.com/zopefoundation/zope.cachedescriptors"
SRC_URI="https://github.com/zopefoundation/zope.cachedescriptors/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN/-/\.}-${PV}"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	# strip rdep specific to namespaces
	sed -i -e "/'setuptools'/d" setup.py || die
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
	find "${BUILD_DIR}" -name '*.pth' -delete || die
}
