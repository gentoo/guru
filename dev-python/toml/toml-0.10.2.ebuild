# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature

TT_PV=2.1.0
TT_P="toml-test-${TT_PV}"
DESCRIPTION="Python library for TOML"
HOMEPAGE="
	https://github.com/uiri/toml
	https://pypi.org/project/toml/
"
SRC_URI="
	https://github.com/uiri/toml/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	test? (
		https://github.com/toml-lang/toml-test/archive/refs/tags/v${TT_PV}.tar.gz
			-> ${TT_P}.gh.tar.gz
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/numpy[${PYTHON_USEDEP}]
		' python3_{12..14})
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	if use test; then
		mv "${WORKDIR}/${TT_P}" toml-test || die
	fi
}

pkg_postinst() {
	optfeature "toml.TomlNumpyEncoder" dev-python/numpy
}
