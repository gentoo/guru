# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

SRC_URI="https://github.com/robotools/fontParts/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="An API for interacting with the parts of fonts"
HOMEPAGE="https://github.com/robotools/fontParts"
LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/booleanOperations-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.8.1[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.24.4[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/fontPens[${PYTHON_USEDEP}] )"

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
}

python_test() {
	"${EPYTHON}" Lib/fontParts/fontshell/test.py -v || die "Tests failed with ${EPYTHON}"
}
