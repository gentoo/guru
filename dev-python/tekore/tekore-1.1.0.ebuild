# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

inherit distutils-r1

DESCRIPTION="Spotify Web API client"
HOMEPAGE="https://tekore.readthedocs.io
	https://github.com/felix-hilden/tekore"
SRC_URI="https://github.com/felix-hilden/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]"

DOCS="readme.rst"

distutils_enable_sphinx docs dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}] dev-python/sphinx-autodoc-typehints[${PYTHON_USEDEP}]
distutils_enable_tests pytest

python_prepare_all() {
	# docs fail: AttributeError: 'PosixPath' object has no attribute 'rstrip'
	sed -i -e 's:sys.path.insert(0, _root):#&:' \
		docs/conf.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	pytest -vv tests/* || die "Tests fail with ${EPYTHON}"
}
