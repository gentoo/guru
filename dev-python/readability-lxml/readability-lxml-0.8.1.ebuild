# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_PN="python-readability"
DESCRIPTION="fast html to text parser (article readability tool)"
HOMEPAGE="
	https://pypi.org/project/readability-lxml/
	https://github.com/buriy/python-readability
"
SRC_URI="https://github.com/buriy/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/lxml-html-clean[${PYTHON_USEDEP}]
	|| (
		dev-python/chardet[${PYTHON_USEDEP}]
		dev-python/faust-cchardet[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	test? (
		dev-python/chardet[${PYTHON_USEDEP}]
		$(python_gen_cond_dep \
			'dev-python/timeout-decorator[${PYTHON_USEDEP}]' python3_11)
	)
"

distutils_enable_tests unittest

distutils_enable_sphinx doc/source \
	dev-python/recommonmark \
	dev-python/sphinx-rtd-theme

src_prepare() {
	rm readability/compat/two.py || die
	distutils-r1_src_prepare
}
