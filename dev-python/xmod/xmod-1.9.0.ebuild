# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Turn any object into a module"
HOMEPAGE="
	https://rec.github.io/xmod/
	https://github.com/rec/xmod/
	https://pypi.org/project/xmod/
"
# no tests in sdist
SRC_URI="
	https://github.com/rec/xmod/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
