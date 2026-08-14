# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Run a block of text as a subprocess"
HOMEPAGE="
	https://github.com/rec/runs/
	https://pypi.org/project/runs/
"
# no tests in sdist
SRC_URI="
	https://github.com/rec/runs/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/xmod[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/tdir[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_prepare_all() {
	sed -e "/'.git'/d" -i test/test_runs.py || die
	distutils-r1_python_prepare_all
}
