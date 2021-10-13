# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{8,9} pypy3 )
DISTUTILS_USE_SETUPTOOLS="rdepend"
inherit distutils-r1

COMMIT="99285aa6b5250b91a837b842dc61b2a96007f3c5"
MYPN="glicko2"
DESCRIPTION="An implementation of the Glicko-2 rating system for Python"
HOMEPAGE="https://github.com/sublee/glicko2"
SRC_URI="https://github.com/sublee/glicko2/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND="!dev-python/glicko2[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MYPN}-${COMMIT}"

distutils_enable_tests setup.py

src_prepare() {
	sed -i -e "s/distribute/setuptools/g" setup.py
	eapply_user
}
