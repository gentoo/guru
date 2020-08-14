# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Numerous useful plugins for pytest"
HOMEPAGE="https://github.com/samuelcolvin/pytest-toolbox"
SRC_URI="https://github.com/samuelcolvin/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

distutils_enable_tests pytest

DEPEND="test? (
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pytest-isort[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

RDEPEND="
	>=dev-python/pytest-3.5.0[${PYTHON_USEDEP}]
	<=dev-python/pytest-5[${PYTHON_USEDEP}]
"

python_prepare_all() {
	# pytest.warning_types.PytestAssertRewriteWarning: asserting the value None, please use "assert is None"
	sed -i -e 's:test_is_uuid_false:_&:' \
		-e 's:test_any_int_false:_&:' \
		tests/test_comparison.py || die

	distutils-r1_python_prepare_all
}
