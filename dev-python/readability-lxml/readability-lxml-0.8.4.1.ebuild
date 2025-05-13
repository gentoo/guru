# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

MY_PN="python-readability"
DESCRIPTION="Fast html to text parser (article readability tool)"
HOMEPAGE="
	https://pypi.org/project/readability-lxml/
	https://github.com/buriy/python-readability
"
SRC_URI="https://github.com/buriy/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/lxml-html-clean[${PYTHON_USEDEP}]
	|| (
		dev-python/faust-cchardet[${PYTHON_USEDEP}]
		dev-python/chardet[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

distutils_enable_sphinx doc/source \
	dev-python/myst-parser \
	dev-python/sphinx-rtd-theme
