# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="Zopfli module for Python"
HOMEPAGE="
	https://pypi.org/project/zopfli/
	https://github.com/fonttools/py-zopfli
"
SRC_URI="$(pypi_sdist_url ${PN} ${PV} .zip)"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/zopfli:="
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_configure() {
	export USE_SYSTEM_ZOPFLI=1
	distutils-r1_src_configure
}
