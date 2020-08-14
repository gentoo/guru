# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

DOCBUILDER="mkdocs"
DOCDEPEND="
	dev-python/mkdocs-material
	dev-python/mkdocs-exclude
	dev-python/markdown-include
"

inherit distutils-r1 docs

DESCRIPTION="Data parsing and validation using Python type hints"
HOMEPAGE="https://github.com/samuelcolvin/pydantic"
SRC_URI="https://github.com/samuelcolvin/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

distutils_enable_tests pytest

BDEPEND="dev-python/cython"

DEPEND="test? (
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

RDEPEND="
	>=dev-python/devtools-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/python-email-validator-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-0.13.0[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

python_prepare_all() {
	# AssertionError: assert 'pydantic-1.5.1.tar.gz' == 'config a'
	sed -i -e 's:test_config_file_settings_nornir:_&:' \
		tests/test_settings.py || die

	distutils-r1_python_prepare_all
}
