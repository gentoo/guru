# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"
KEYWORDS="~amd64"
DESCRIPTION="Python bindings for the Skia Path Ops"
HOMEPAGE="
	https://github.com/fonttools/skia-pathops
	https://skia.org/dev/present/pathops
"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	~media-libs/skia-80:=
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest-cython[${PYTHON_USEDEP}]
		dev-python/pytest-randomly[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"
#	dev-python/setuptools_git_ls_files[${PYTHON_USEDEP}]

#S="${WORKDIR}/${PN}-${MY_PV#v}"

distutils_enable_tests pytest

pkg_setup() {
	export BUILD_SKIA_FROM_SOURCE=0
}

python_prepare_all() {
	sed -e '/doctest-cython/d' -i tox.ini
	distutils-r1_python_prepare_all
}
