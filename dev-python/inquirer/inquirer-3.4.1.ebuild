# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 #pypi

DESCRIPTION="Common interactive command line user interfaces, based on Inquirer.js"
HOMEPAGE="
	https://github.com/magmax/python-inquirer/
	https://pypi.org/project/inquirer/
"
# no tests in sdist
SRC_URI="
	https://github.com/magmax/python-inquirer/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/python-inquirer-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/blessed-1.19.0[${PYTHON_USEDEP}]
	>=dev-python/readchar-4.2.0[${PYTHON_USEDEP}]
	>=dev-python/editor-1.6.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
