# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="A library to provide a bridge from Glyphs source files to UFOs"
HOMEPAGE="https://github.com/googlei18n/glyphsLib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="Apache-2.0 MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-4.14[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.8[${PYTHON_USEDEP}]
"

BDEPEND="
	app-arch/unzip
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? (
		dev-python/defcon[${PYTHON_USEDEP}]
		dev-python/ufoNormalizer[${PYTHON_USEDEP}]
		>=app-text/xmldiff-2.2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	sed -e '/\<wheel\>/d' -i setup.cfg
	distutils-r1_python_prepare_all
}
