# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="Noto fonts support tools and scripts plus web site generation"
HOMEPAGE="
	https://pypi.org/project/notofonttools/
	https://github.com/googlefonts/nototools
"

LICENSE="Apache-2.0 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/fonttools-4.11.0[${PYTHON_USEDEP}]"

# TODO: Some dependencies are unpackaged
RESTRICT="test"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "nototools.shape_diff module" "dev-python/booleanOperations dev-python/defcon dev-python/pillow"
}
