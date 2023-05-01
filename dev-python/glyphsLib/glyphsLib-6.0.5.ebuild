# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )
inherit distutils-r1

DESCRIPTION="A library to provide a bridge from Glyphs source files to UFOs"
HOMEPAGE="https://github.com/googlefonts/glyphsLib"
SRC_URI="https://github.com/googlefonts/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0 MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-4.27.1[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/openstep-plist-0.3.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/setuptools-scm-6.0[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/defcon[${PYTHON_USEDEP}]
		dev-python/ufoNormalizer[${PYTHON_USEDEP}]
		dev-python/ufo2ft[${PYTHON_USEDEP}]
		>=app-text/xmldiff-2.2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
	distutils-r1_python_prepare_all
}
