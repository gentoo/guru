# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="
	dev-python/mkdocs-material
	dev-python/markdown-include
	dev-python/pymdown-extensions
"

inherit distutils-r1 docs

DESCRIPTION="A lightweight and modern animated terminal window"
HOMEPAGE="https://termynal.github.io/termynal.py/ https://github.com/termynal/termynal.py"
SRC_URI="https://github.com/termynal/${PN}.py/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}.py-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/markdown[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-1.4[${PYTHON_USEDEP}]
	<dev-python/mkdocs-2.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/pytest-mock-3.11.1[${PYTHON_USEDEP}]
		<dev-python/pytest-mock-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-6.0.1[${PYTHON_USEDEP}]
		<dev-python/pyyaml-7.0.0[${PYTHON_USEDEP}]
		dev-util/ruff[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
