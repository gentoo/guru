# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7,8} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

MY_PV=${PV/_p/.post}

DESCRIPTION="Plugin for pytest that shows failures and errors instantly"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-instafail
	https://pypi.org/project/pytest-instafail
"
SRC_URI="https://github.com/pytest-dev/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"
RDEPEND="
	>=dev-python/pytest-2.9[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/pexpect[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"
S="${WORKDIR}/${PN}-${MY_PV}"

python_test() {
	distutils_install_for_testing
	pytest -vv || die "Testsuite failed under ${EPYTHON}"
}
