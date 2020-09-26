# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_7 pypy3)

inherit distutils-r1

COMMIT="99285aa6b5250b91a837b842dc61b2a96007f3c5"

DESCRIPTION="An implementation of the Glicko-2 rating system for Python"
HOMEPAGE="https://github.com/sublee/glicko2"
SRC_URI="https://github.com/sublee/glicko2/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${COMMIT}"

distutils_enable_tests setup.py

src_prepare() {
	sed -i -e "s/distribute/setuptools/g" setup.py
	eapply_user
}
