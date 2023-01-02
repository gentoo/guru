# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="URL parsing and manipulation made easy."
HOMEPAGE="https://github.com/gruns/furl"
SRC_URI="https://github.com/gruns/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="test? ( dev-python/flake8[${PYTHON_USEDEP}] )
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/orderedmultidict[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
