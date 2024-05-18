# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Convert HTML to Markdown"
HOMEPAGE="
	https://pypi.org/project/markdownify/
	https://github.com/matthewwithanm/python-markdownify
"

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
