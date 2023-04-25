# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Automatic documentation from sources, for MkDocs."
HOMEPAGE="https://github.com/mkdocstrings/mkdocstrings https://pypi.org/project/mkdocstrings"
SRC_URI="https://github.com/mkdocstrings/mkdocstrings/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/mkdocstrings-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/mkdocs[${PYTHON_USEDEP}]
	test? (
		dev-python/pymdown-extensions[${PYTHON_USEDEP}]
		dev-python/mkdocs-autorefs[${PYTHON_USEDEP}]
		dev-python/mkdocs-material[${PYTHON_USEDEP}]
		dev-python/mkdocs-mkdocstrings-python[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest

src_prepare() {
	rm "${S}/tests/test_plugin.py"
	default
}
