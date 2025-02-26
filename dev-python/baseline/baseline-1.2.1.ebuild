# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{11..13} python3_13t )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Easy string baseline"
HOMEPAGE="
	https://github.com/dmgass/baseline
	https://pypi.org/project/baseline/
"
SRC_URI="https://github.com/dmgass/baseline/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/${P}-fix-setup.patch"
)

distutils_enable_tests unittest
