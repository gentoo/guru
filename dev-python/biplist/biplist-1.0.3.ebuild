# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="A binary plist parser/generator for Python"
HOMEPAGE="https://pypi.org/project/biplist/ https://github.com/wooster/biplist"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

RESTRICT="test"
# Because using dev-python/nose test framework -
# that is abandonware for 10 years
# Related ticket on the upstream: https://github.com/wooster/biplist/issues/14

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=( "${FILESDIR}/${PN}-python3-compat.patch" )
