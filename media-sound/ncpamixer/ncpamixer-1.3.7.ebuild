# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A ncurses mixer for PulseAudio inspired by pavucontrol"
HOMEPAGE="https://github.com/fulhax/ncpamixer"
SRC_URI="https://github.com/fulhax/ncpamixer/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +wide"

DEPEND="
	media-libs/libpulse
	sys-libs/ncurses:=
"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( virtual/pandoc )"

CMAKE_USE_DIR="${S}/src"

src_prepare() {
	sed -i "/-Werror/d" src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_MANPAGES=OFF
		-DUSE_WIDE="$(usex wide)"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && { pandoc -s -t man src/man/ncpamixer.1.md -o ncpamixer.1 || die; }
}

src_install() {
	cmake_src_install
	use doc && doman ncpamixer.1
}
