# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

inherit distutils-r1

DESCRIPTION="standard API for systems which build Python packages"
HOMEPAGE="
	https://github.com/pypa/pep517
	https://pypi.org/project/pep517
"
SRC_URI="https://github.com/pypa/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	>=dev-python/flit_core-2[${PYTHON_USEDEP}]
	<dev-python/flit_core-3[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]

	$(python_gen_cond_dep 'dev-python/importlib_metadata[${PYTHON_USEDEP}]' python3_{6,7})
	$(python_gen_cond_dep 'dev-python/zipp[${PYTHON_USEDEP}]' python3_{6,7})
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
