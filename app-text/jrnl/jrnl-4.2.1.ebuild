# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

DESCRIPTION="Collect your thoughts and notes without leaving the command line"
HOMEPAGE="https://jrnl.sh"
SRC_URI="https://github.com/jrnl-org/jrnl/archive/refs/tags/v${PV}.tar.gz  -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}"/${P}-tomllib.patch
)

DEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/parsedatetime[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"
EPYTEST_PLUGINS=( pytest-{bdd,xdist} )
distutils_enable_tests pytest
