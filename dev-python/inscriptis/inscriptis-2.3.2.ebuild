# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="HTML to text converter"
HOMEPAGE="
	https://pypi.org/project/inscriptis/
	https://github.com/weblyzard/inscriptis
"
SRC_URI="https://github.com/weblyzard/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

DOCS=( AUTHORS {CONTRIBUTING,RENDERING}.md README.rst TODO.txt )

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/myst_parser \
	dev-python/alabaster
