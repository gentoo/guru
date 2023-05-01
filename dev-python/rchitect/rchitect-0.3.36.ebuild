# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Interoperate R with Python"
HOMEPAGE="
	https://pypi.org/project/rchitect/
	https://github.com/randy3k/rchitect
"
SRC_URI="https://github.com/randy3k/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}-github.tar.gz"

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
