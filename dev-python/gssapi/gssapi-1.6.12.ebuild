# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} )
DOCS_BUILDER="sphinx"
DOCS_DIR="docs/source"
DOCS_DEPEND="
	>=dev-python/recommonmark-0.4.0
	>dev-python/sphinx_rtd_theme-0.2.5
"
inherit distutils-r1 docs

DESCRIPTION="A Python interface to RFC 2743/2744 (plus common extensions)"
HOMEPAGE="
	https://github.com/pythongssapi/python-gssapi
	https://pypi.org/project/gssapi
"
SRC_URI="https://github.com/pythongssapi/python-${PN}/releases/download/v${PV}/python-${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#help wanted
RESTRICT="test"

S="${WORKDIR}/python-${P}"

RDEPEND="dev-python/decorator[${PYTHON_USEDEP}]"

BDEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-python/k5test[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests --install nose
