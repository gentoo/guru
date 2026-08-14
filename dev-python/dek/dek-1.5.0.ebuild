# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 #pypi

DESCRIPTION="The decorator-decorator"
HOMEPAGE="
	https://rec.github.io/dek/
	https://github.com/rec/dek/
	https://pypi.org/project/dek/
"
# no tests in sdist
SRC_URI="
	https://github.com/rec/dek/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/xmod[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
