# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Runtime inspection utilities for Python typing module"
HOMEPAGE="https://github.com/ilevkivskyi/typing_inspect"

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
