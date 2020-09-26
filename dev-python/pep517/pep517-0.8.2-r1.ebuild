# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_7 )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

inherit distutils-r1

DESCRIPTION="standard API for systems which build Python packages"
HOMEPAGE="
	https://github.com/pypa/pep517
	https://pypi.org/project/pep517
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/flit_core-2[${PYTHON_USEDEP}]
	<dev-python/flit_core-3[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]

	$(python_gen_cond_dep 'dev-python/importlib_metadata[${PYTHON_USEDEP}]' python3_7)
	$(python_gen_cond_dep 'dev-python/zipp[${PYTHON_USEDEP}]' python3_7)
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	sed -i 's|addopts=--flake8||' pytest.ini
	default
}

python_test() {
	pytest -vv \
			--deselect tests/test_meta.py::test_classic_package		\
			--deselect tests/test_meta.py::test_meta_output			\
			--deselect tests/test_meta.py::test_meta_for_this_package || die
}
