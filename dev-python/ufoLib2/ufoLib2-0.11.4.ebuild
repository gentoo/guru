# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_DEPEND="
	dev-python/sphinx_rtd_theme
	dev-python/typing-extensions
"
DOCS_DIR="${S}/docs/source"
DOCS_BUILDER="sphinx"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 docs

DESCRIPTION="A UFO font library"
HOMEPAGE="https://github.com/fonttools/ufoLib2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/attrs-19.2.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.0.0[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? (
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	)
"
BDEPEND="app-arch/unzip"

distutils_enable_tests pytest

python_prepare_all() {
	sed -e '/\<wheel\>/d' -i setup.cfg || die
	distutils-r1_python_prepare_all
}
