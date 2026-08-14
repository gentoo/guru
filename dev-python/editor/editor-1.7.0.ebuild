# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Open the default text editor"
HOMEPAGE="
	https://rec.github.io/editor/
	https://github.com/rec/editor/
	https://pypi.org/project/editor/
"
# no tests in dist
SRC_URI="
	https://github.com/rec/editor/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/runs[${PYTHON_USEDEP}]
	dev-python/xmod[${PYTHON_USEDEP}]
	virtual/editor
"
BDEPEND="
	test? (
		dev-python/tdir[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
