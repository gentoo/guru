# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Automatically link across pages in MkDocs."
HOMEPAGE="https://github.com/mkdocstrings/autorefs https://pypi.org/project/autorefs"
SRC_URI="https://github.com/mkdocstrings/autorefs/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/autorefs-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
BDEPEND="
	dev-python/pdm-pep517[${PYTHON_USEDEP}]
	dev-python/mkdocs[${PYTHON_USEDEP}]
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest
