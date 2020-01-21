# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Sphinx objects.inv Inspection/Manipulation Tool"
HOMEPAGE="https://github.com/bskinn/sphobjinv"
SRC_URI="https://github.com/bskinn/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86 "
SLOT="0"

RDEPEND="
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/fuzzywuzzy[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]"

DEPEND="test? ( dev-python/timeout-decorator[${PYTHON_USEDEP}]
		dev-python/stdio-mgr[${PYTHON_USEDEP}] )"

PATCHES="${FILESDIR}/${P}-skip-tests.patch"

distutils_enable_sphinx doc/source dev-python/sphinx_rtd_theme
distutils_enable_tests pytest

python_test() {
	pytest -vv ${PN}/test/* || die "Tests fail with ${EPYTHON}"
}
