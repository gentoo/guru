# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.code.sf.net/p/quakespasm/quakespasm"
else
	SRC_URI="https://downloads.sourceforge.net/project/${PN}/Source/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Modern, cross-platform Quake 1 engine based on FitzQuake"
HOMEPAGE="https://quakespasm.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
IUSE="sdl2"

DEPEND="
	media-libs/libglvnd
	media-libs/libmad
	media-libs/libvorbis
	sdl2? ( media-libs/libsdl2[opengl] )
	!sdl2? ( media-libs/libsdl[opengl] )
"
RDEPEND="${DEPEND}"
DOCS=( Quakespasm.html  Quakespasm-Music.txt  Quakespasm.txt )

PATCHES=(
	# bug 795759, 887677
	"${FILESDIR}/${P}-makefile.patch"
)

src_compile() {
	cd Quake || die
	emake COMMON_LIBS="-lm -lOpenGL" USE_SDL2=$(usex sdl2 1 0) STRIP="/bin/true"
}

src_install() {
	einstalldocs
	dobin Quake/quakespasm
}
