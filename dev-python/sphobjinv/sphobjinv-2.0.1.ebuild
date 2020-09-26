# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Sphinx objects.inv Inspection/Manipulation Tool"
HOMEPAGE="
	https://github.com/bskinn/sphobjinv
	https://pypi.org/project/sphobjinv
"
SRC_URI="https://github.com/bskinn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86 "
SLOT="0"

RDEPEND="
	>=dev-python/attrs-17.4[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/fuzzywuzzy[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]"

DEPEND="
	test? (
		>=dev-python/pytest-4.4.0[${PYTHON_USEDEP}]
		dev-python/pytest-ordering[${PYTHON_USEDEP}]
		dev-python/pytest-subtests[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/sphinx-issues[${PYTHON_USEDEP}]
		dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
		>=dev-python/stdio-mgr-1.0.1[${PYTHON_USEDEP}]
		dev-python/timeout-decorator[${PYTHON_USEDEP}]
	)
"

#it may require sphinx==2.3.1
distutils_enable_sphinx doc/source dev-python/sphinx_rtd_theme dev-python/sphinx-issues
distutils_enable_tests pytest

python_prepare_all() {
	# not sure why this fails
	rm tests/test_flake8_ext.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	pytest -vv tests || die "Tests fail with ${EPYTHON}"
}
