# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="A Python handler for mkdocstrings."
HOMEPAGE="https://github.com/mkdocstrings/python https://pypi.org/project/mkdocstrings-python"
SRC_URI="https://github.com/mkdocstrings/python/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
ISUE="test"

RDEPEND=""
BDEPEND="
	dev-python/pdm-pep517[${PYTHON_USEDEP}]
	dev-python/mkdocs[${PYTHON_USEDEP}]
	dev-python/griffe[${PYTHON_USEDEP}]
	test? (
		dev-python/mkdocs-mkdocstrings[${PYTHON_USEDEP}]
		dev-python/mkdocs-autorefs[${PYTHON_USEDEP}]
		dev-python/pymdown-extensions[${PYTHON_USEDEP}]
		dev-python/mkdocs_pymdownx_material_extras[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest
