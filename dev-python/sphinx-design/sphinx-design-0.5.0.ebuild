# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A sphinx extension for designing beautiful, view size responsive web components"
HOMEPAGE="https://sphinx-design.readthedocs.io https://github.com/executablebooks/sphinx-design"
SRC_URI="https://github.com/executablebooks/sphinx-design/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/myst-parser-3[${PYTHON_USEDEP}]
	>=dev-python/furo-2022.06.04[${PYTHON_USEDEP}]
"

src_prepare() {
	find "${S}/docs" -type f -exec sed -i 's/sphinxcontrib.napoleon/sphinx\.ext\.napoleon/g' {} \;
	rm -rf "${S}/tests"
	use doc && HTML_DOCS="${S}/docs/_build/html"
	distutils-r1_src_prepare
}

distutils_enable_sphinx docs --no-autodoc
