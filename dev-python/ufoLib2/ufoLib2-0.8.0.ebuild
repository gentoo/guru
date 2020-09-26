# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="A UFO font library"
HOMEPAGE="https://github.com/fonttools/ufoLib2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# fs not pulled in by fonttools
RDEPEND="
	>=dev-python/fonttools-4.0.0[${PYTHON_USEDEP}]
	dev-python/fs[${PYTHON_USEDEP}]
	>=dev-python/attrs-19.3.0[${PYTHON_USEDEP}]
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
distutils_enable_sphinx docs/source dev-python/typing-extensions dev-python/sphinx_rtd_theme

python_prepare_all() {
	sed -e '/\<wheel\>/d' -i setup.cfg || die
	distutils-r1_python_prepare_all
}
