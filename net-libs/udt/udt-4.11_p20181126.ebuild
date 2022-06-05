# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="0de191f6f43c0e03bb22eaf2ae4911ce5def0e10"

DESCRIPTION="UDT is a UDP based data transport protocol"
HOMEPAGE="https://github.com/eisenhauer/udt4"
SRC_URI="https://github.com/eisenhauer/udt4/archive/${COMMIT}.tar.gz -> ${PF}.gh.tar.gz"
S="${WORKDIR}/${PN}4-${COMMIT}"

LICENSE="BSD"
SLOT="4"
KEYWORDS="~amd64"

DOCS=( udt4/README.txt udt4/RELEASE_NOTES.txt udt4/draft-gg-udt-xx.txt )

src_configure(){
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir)
		-DUDT4_QUIET=OFF
	)
	cmake_src_configure
}

src_install(){
	cmake_src_install
	local HTML_DOCS=( udt4/doc/* )
	einstalldocs
}
