# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A graphical grub2 settings manager"
HOMEPAGE="https://launchpad.net/grub-customizer"
SRC_URI="https://launchpad.net/grub-customizer/$(ver_cut 1-2)/${PV}/+download/grub-customizer_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/libarchive:=
	dev-cpp/gtkmm:3.0
	dev-libs/openssl:=
"
RDEPEND="
	${DEPEND}
	sys-apps/hwinfo
"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	cmake_src_prepare
	gunzip misc/manpage.gz || die
	sed -i -e 's/manpage.gz/manpage/' -e 's/\(grub-customizer.1\).gz/\1/' CMakeLists.txt || die
}
