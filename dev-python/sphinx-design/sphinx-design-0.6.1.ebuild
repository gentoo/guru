# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_AUTODOC=0
DOCS_BUILDER="sphinx"
DOCS_DIR="docs"

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 docs

DESCRIPTION="A sphinx extension for designing beautiful responsive web components"
HOMEPAGE="https://github.com/executablebooks/sphinx-design https://pypi.org/project/sphinx_design/"
SRC_URI="https://github.com/executablebooks/sphinx-design/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	test? (
		dev-python/pytest-regressions[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/myst-parser[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
