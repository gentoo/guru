# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="An API for interacting with the parts of fonts"
HOMEPAGE="
	https://pypi.org/project/fontParts/
	https://github.com/robotools/fontParts
"
SRC_URI="https://github.com/robotools/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/booleanOperations-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.4.8[${PYTHON_USEDEP}]
	>=dev-python/fontPens-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-3.32.0[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.9.2[${PYTHON_USEDEP}]
	$(python_gen_cond_dep \
		'>=dev-python/unicodedata2-14.0.0[${PYTHON_USEDEP}]' \
		python3_{9..10})
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

distutils_enable_sphinx documentation/source

src_configure() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
	distutils-r1_src_configure
}
