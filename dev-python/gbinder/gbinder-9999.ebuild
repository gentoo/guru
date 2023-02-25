# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

if [[ ${PV} != *9999* ]]; then
	MY_PN="${PN}-python"
	MY_P="${MY_PN}-${PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://github.com/erfanoabdi/gbinder-python/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/erfanoabdi/gbinder-python.git"
fi

DESCRIPTION="Python bindings for libgbinder"
HOMEPAGE="https://github.com/erfanoabdi/gbinder-python"
LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-libs/gbinder
	dev-libs/libglibutil"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-python/cython[${PYTHON_USEDEP}]
"

python_compile() {
	distutils-r1_python_compile --cython
}
