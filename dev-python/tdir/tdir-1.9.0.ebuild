# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Create and fill a temporary directory"
HOMEPAGE="
	https://rec.github.io/tdir/
	https://github.com/rec/tdir/
	https://pypi.org/project/tdir/
"
# no tests in sdist
SRC_URI="
	https://github.com/rec/tdir/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/dek[${PYTHON_USEDEP}]
	dev-python/xmod[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
