# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="ASCII plist parser written in Cython"
HOMEPAGE="
	https://pypi.org/project/openstep-plist/
	https://github.com/fonttools/openstep-plist
"
SRC_URI="$(pypi_sdist_url ${PN} $(pypi_translate_version ${PV}) .zip)"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

BDEPEND="
	>=dev-python/cython-0.28.5[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-cython[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	find "${S}" -name '*.cpp' -delete || die
}

src_configure() {
	distutils-r1_src_configure
	export SETUPTOOLS_SCM_PRETEND_VERSION="$(pypi_translate_version ${PV})"
}
