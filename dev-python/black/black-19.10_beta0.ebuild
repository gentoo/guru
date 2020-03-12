# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

MY_PV="19.10b0"
DESCRIPTION="The uncompromising Python code formatter"
HOMEPAGE="https://github.com/psf/black https://pypi.org/project/black/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-python/appdirs-1.4[${PYTHON_USEDEP}]
	>=dev-python/attrs-18.1[${PYTHON_USEDEP}]
	>=dev-python/click-6.5[${PYTHON_USEDEP}]
	>=dev-python/mypy_extensions-0.4.3[${PYTHON_USEDEP}]
	>=dev-python/pathspec-0.6[${PYTHON_USEDEP}]
	>=dev-python/regex-2019.11.1[${PYTHON_USEDEP}]
	>=dev-python/toml-0.9.4[${PYTHON_USEDEP}]
	>=dev-python/typed-ast-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/dataclasses[${PYTHON_USEDEP}]' python3_6)
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${PN}-${MY_PV}"

python_test() {
	python -m unittest tests/test_black.py || die "Tests fail with ${EPYTHON}"
}