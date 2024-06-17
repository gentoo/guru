# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

DESCRIPTION="Powerful and Lightweight Python Tree Data Structure with various plugins"
HOMEPAGE="https://anytree.readthedocs.io/"

SRC_URI="https://github.com/c0fec0de/anytree/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

IUSE="dot"

RDEPEND="
	dot? (
		media-gfx/graphviz
	)
"

DEPEND="${RDEPEND}
	test? (
		$(python_gen_cond_dep '
			dev-python/six[${PYTHON_USEDEP}]
		')
	)
"

distutils_enable_sphinx docs
distutils_enable_tests pytest

src_prepare(){
	default

	mkdir "${S}/tests/dotexport" || die
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	local -x EPYTEST_DESELECT=()

	if ! use dot; then
		EPYTEST_DESELECT+=(
			"tests/test_dotexport.py::test_tree_png"
		)
	fi

	cd "${S}/tests" || die
	distutils-r1_python_test
}
