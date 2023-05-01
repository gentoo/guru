# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

DISTUTILS_USE_PEP517="setuptools"

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

PATCHES=(
	"${FILESDIR}"/gbinder-1.1.1-setuptools.patch
)


DEPEND="dev-libs/gbinder
	dev-libs/libglibutil"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-python/cython[${PYTHON_USEDEP}]
	${DISTUTILS_DEPS}
"

python_configure_all () {
	DISTUTILS_ARGS=( --cython )
}
