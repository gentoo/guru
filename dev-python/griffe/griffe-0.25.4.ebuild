# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Signatures for entire Python programs."
HOMEPAGE="https://github.com/mkdocstrings/griffe https://pypi.org/project/griffe/"
SRC_URI="https://github.com/mkdocstrings/griffe/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
ISUE="test"

RDEPEND=""
BDEPEND="
	dev-python/pdm-pep517[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest
