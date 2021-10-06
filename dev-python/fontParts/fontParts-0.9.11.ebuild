# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="An API for interacting with the parts of fonts"
HOMEPAGE="https://github.com/robotools/fontParts"
SRC_URI="https://github.com/robotools/fontParts/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/booleanOperations-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.4.8[${PYTHON_USEDEP}]
	>=dev-python/fonttools-3.32.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? ( dev-python/fontPens[${PYTHON_USEDEP}] )
"

RESTRICT="!test? ( test )"

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
}

python_test() {
	"${EPYTHON}" Lib/fontParts/fontshell/test.py -v || die "Tests failed with ${EPYTHON}"
}
