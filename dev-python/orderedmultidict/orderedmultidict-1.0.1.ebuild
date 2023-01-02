# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Ordered Multivalue Dictionary. Helps power furl. "
HOMEPAGE="https://github.com/gruns/orderedmultidict"
SRC_URI="https://github.com/gruns/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="test? ( dev-python/flake8[${PYTHON_USEDEP}] )
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
