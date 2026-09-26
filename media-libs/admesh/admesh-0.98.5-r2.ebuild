# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit libtool

DESCRIPTION="CLI and C library for processing triangulated solid meshes"
HOMEPAGE="https://admesh.readthedocs.io/"
if [[ ${PV} == *9999* ]] ; then
	inherit git-r3 cmake
	EGIT_REPO_URI="https://github.com/admesh/${PN}"
else
	SRC_URI="https://github.com/admesh/${PN}/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi
LICENSE="GPL-2"
SLOT="0"

RESTRICT="test"

PATCHES=( "${FILESDIR}/slic3r-${P}.patch" )

src_prepare() {
	default
	if [[ "${PV}" != *9999* ]]; then
		elibtoolize
	else
		sed -i "s/cmake_minimum_required(VERSION 3.5)/cmake_minimum_required(VERSION 4.0)/" \
			CMakeLists.txt || die
		cmake_prepare
	fi
}

src_install() {
	if [[ "${PV}" != *9999* ]]; then
		default
		# See: https://bugs.gentoo.org/941097
		find "${ED}" -name '*.la' -delete || die
	else
		cmake_src_install
	fi
}
