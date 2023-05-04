# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="A bridge from Glyphs source files (.glyphs) to UFOs"
HOMEPAGE="
	https://pypi.org/project/glyphsLib/
	https://github.com/googlefonts/glyphsLib
"

LICENSE="Apache-2.0 MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-4.38.0[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/openstep-plist-0.3.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep \
		'dev-python/unicodedata2[${PYTHON_USEDEP}]' 3.10)
"
BDEPEND="
	test? (
		>=app-text/xmldiff-2.2[${PYTHON_USEDEP}]
		dev-python/defcon[${PYTHON_USEDEP}]
		dev-python/ufoNormalizer[${PYTHON_USEDEP}]
		dev-python/ufo2ft[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
