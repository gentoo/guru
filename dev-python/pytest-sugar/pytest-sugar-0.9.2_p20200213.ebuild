# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

COMMIT="66f6d9f9311a176ffafdfe00cb8c487d45b6a735"

DESCRIPTION="Plugin for pytest that changes the default look and feel of pytest"
HOMEPAGE="
	https://pivotfinland.com/pytest-sugar
	https://github.com/Teemu/pytest-sugar
	https://pypi.org/project/pytest-sugar
"
SRC_URI="https://github.com/Teemu/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/packaging-14.1[${PYTHON_USEDEP}]
	<dev-python/pytest-5.4[${PYTHON_USEDEP}]
	>=dev-python/pytest-xdist-1.14[${PYTHON_USEDEP}]
	>=dev-python/termcolor-1.1.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${COMMIT}"

distutils_enable_tests pytest
