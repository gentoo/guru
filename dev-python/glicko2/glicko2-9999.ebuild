# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{6,7} pypy3)

inherit distutils-r1

case "${PV}" in
9999)
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/sublee/glicko2.git"
	inherit git-r3
	;;
esac

DESCRIPTION="An implementation of the Glicko-2 rating system for Python"
HOMEPAGE="https://github.com/sublee/glicko2"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i -e "s/distribute/setuptools/g" setup.py
	eapply_user
}

python_test() {
	"${PYTHON}" setup.py test || die
}
