# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Convert HTML to Markdown"
HOMEPAGE="
	https://pypi.org/project/markdownify/
	https://github.com/matthewwithanm/python-markdownify
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	!dev-python/django-markdownify
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	mv tests markdownify/tests || die
}
