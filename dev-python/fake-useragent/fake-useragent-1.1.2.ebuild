# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="Up to date simple useragent faker with real world database"
HOMEPAGE="
	https://github.com/fake-useragent/fake-useragent
	https://pypi.org/project/fake-useragent/
"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	$(python_gen_cond_dep \
		'dev-python/importlib_resources[${PYTHON_USEDEP}]' python3_9
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs --no-autodoc

python_prepare_all() {
	# do not depend on pytest-cov
	rm pytest.ini || die

	distutils-r1_python_prepare_all
}
