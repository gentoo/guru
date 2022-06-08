# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} ) # python3_11 depends on dev-python/mypy_extensions

inherit distutils-r1

DESCRIPTION="Runtime inspection utilities for Python typing module"
HOMEPAGE="https://github.com/ilevkivskyi/typing_inspect"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/mypy_extensions-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4.2[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_test() {
	# https://github.com/ilevkivskyi/typing_inspect/issues/84
	local EPYTEST_DESELECT=( 'test_typing_inspect.py::GetUtilityTestCase::test_typed_dict_typing_extension' )
	epytest
}
