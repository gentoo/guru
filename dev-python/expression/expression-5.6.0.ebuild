# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature

MY_PN="Expression"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Practical functional programming for Python 3.10+"
HOMEPAGE="
	https://github.com/dbrattli/Expression
	https://pypi.org/project/expression/
"
SRC_URI="https://github.com/dbrattli/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			>=dev-python/pydantic-2.6.2[${PYTHON_USEDEP}]
		' python3_{12..14})
	)
"

EPYTEST_PLUGINS=( hypothesis pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	default

	sed '/^version = /s/"0.0.0"/"'${PV}'"/' -i pyproject.toml || die
}

python_test() {
	local EPYTEST_IGNORE=()

	if ! has_version "dev-python/pydantic[${PYTHON_USEDEP}]"; then
		EPYTEST_IGNORE+=(
			# pydantic
			tests/test_block.py
			tests/test_option.py
			tests/test_result.py
		)
	fi

	epytest
}

pkg_setup() {
	optfeature "Pydantic support" ">=dev-python/pydantic-2.6.2"
}
