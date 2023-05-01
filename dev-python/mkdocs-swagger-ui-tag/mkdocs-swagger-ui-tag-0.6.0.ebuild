# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="MkDocs Swagger UI Tag"
HOMEPAGE="
	https://blueswen.github.io/mkdocs-swagger-ui-tag/
	https://pypi.org/project/mkdocs-swagger-ui-tag/
	https://github.com/Blueswen/mkdocs-swagger-ui-tag
"
SRC_URI="https://github.com/Blueswen/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/beautifulsoup4-4.11.1[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/click[${PYTHON_USEDEP}]
		dev-python/mkdocs-material[${PYTHON_USEDEP}]
	)
"

HTML_DOCS=( docs/. )

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	rm docs/sitemap.xml.gz || die
}
