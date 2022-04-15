# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Interoperate R with Python"
HOMEPAGE="
	https://pypi.org/project/rchitect/
	https://github.com/randy3k/rchitect
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/cffi-1.10.0[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/pytest-mock[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${P}-no-pytest-runner.patch" )

distutils_enable_tests pytest
