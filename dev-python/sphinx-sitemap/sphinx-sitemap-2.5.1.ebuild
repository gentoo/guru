# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
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

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

#distutils_enable_sphinx docs/source \
	#dev-python/furo \
	#dev-python/sphinxemoji \
	#dev-python/sphinxext-opengraph \
	#dev-python/sphinx-contributors
