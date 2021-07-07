# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

SRC_URI="https://github.com/daltonmaag/statmake/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="Generate STAT tables for variable fonts from .stylespace files"
HOMEPAGE="https://github.com/daltonmaag/statmake"
LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/fonttools[${PYTHON_USEDEP}]
	')
	dev-python/cattrs[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		$(python_gen_cond_dep 'dev-python/ufo2ft[${PYTHON_USEDEP}]')
	)
"

distutils_enable_tests pytest

python_install() {
	distutils-r1_python_install --skip-build
	python_domodule "src/${PN}"
}

python_test() {
	local -x PYTHONPATH="${S}/src:${PYTHONPATH}"
	epytest -vv || die "Tests fail with ${EPYTHON}"
}
