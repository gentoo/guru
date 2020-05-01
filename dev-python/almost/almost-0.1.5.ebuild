# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8} pypy3 )

inherit distutils-r1

COMMIT="cc3eeb0abde7ff95a222d571443989c74a112ff7"

DESCRIPTION="A helper for approximate comparison"
HOMEPAGE="
	https://github.com/sublee/almost
	https://pypi.org/project/almost
"
SRC_URI="https://github.com/sublee/almost/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
DEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}-${COMMIT}"

#no tests in pypi tarball
distutils_enable_tests setup.py

src_prepare() {
	sed -i "s|distribute|setuptools|" setup.py || die
	default
}
