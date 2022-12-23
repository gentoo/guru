# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="A Python library providing data structure and operations for intervals."
HOMEPAGE="https://github.com/AlexandreDecan/portion"
SRC_URI="https://github.com/AlexandreDecan/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="test? (
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/coverage[${PYTHON_USEDEP}]
	dev-python/black[${PYTHON_USEDEP}]
)"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/sortedcontainers[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
