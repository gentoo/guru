# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_VERIFY_REPO=https://github.com/joerick/pyinstrument
inherit distutils-r1 pypi

DESCRIPTION="Call stack profiler for Python"
HOMEPAGE="
	https://github.com/joerick/pyinstrument/
	https://pypi.org/project/pyinstrument/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		>=dev-python/cffi-1.17.0[${PYTHON_USEDEP}]
		>=dev-python/greenlet-3[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

python_prepare_all() {
	# hack away flaky dep
	sed -e '/from flaky import flaky/d' -i test/util.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	rm -rf pyinstrument || die
	epytest
}
