# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1 pypi

DESCRIPTION="A binary plist parser/generator for Python"
HOMEPAGE="https://pypi.org/project/biplist/ https://github.com/wooster/biplist"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
# DEPEND="test? ( ${RDEPEND} )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=( "${FILESDIR}/${PN}-python3-compat.patch" )

# Removed from ::gentoo
# distutils_enable_tests nose
