# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Provides Quality Assurance (QA) tools for cmake"
HOMEPAGE="
	https://pypi.org/project/cmakelang/
	https://github.com/cheshirekow/cmake_format
"
SRC_URI="https://github.com/cheshirekow/cmake_format/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/cmake_format-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
"

DOCS=( cmakelang/doc/README.rst )

PATCHES=(
	"${FILESDIR}/cmakelang-0.6.13-fix-setup.py.patch"
)

EPYTEST_DESELECT=(
	# fails because the project lags behind CMake
	cmakelang/test/command_db_test.py
	# tests require network access
	cmakelang/test/screw_users_test.py
)

# tests fail for 3.11+ because of hacky use of private class members
# distutils_enable_tests pytest
