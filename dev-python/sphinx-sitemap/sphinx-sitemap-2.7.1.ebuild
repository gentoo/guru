# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Sitemap generator for Sphinx"
HOMEPAGE="
	https://pypi.org/project/sphinx-sitemap/
	https://github.com/jdillard/sphinx-sitemap
"
SRC_URI="https://github.com/jdillard/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="git"

RDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx-last-updated-by-git[${PYTHON_USEDEP}]
"
BDEPEND="
	test? ( dev-python/gitpython[${PYTHON_USEDEP}] )
"

DOCS=( {CHANGELOG,README}.rst )

distutils_enable_tests pytest

src_prepare() {
	#sed "s:\(GIT_TAG_OUTPUT =\) .*:\1 b'v${PV}':" -i docs/source/conf.py
	distutils-r1_src_prepare
}

#distutils_enable_sphinx docs/source \
	#dev-python/furo \
	#dev-python/sphinxemoji \
	#dev-python/sphinxext-opengraph \
	#dev-python/sphinx-contributors
