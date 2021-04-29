# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils git-r3

DESCRIPTION="Blackvoxel Video Game"
HOMEPAGE="https://www.blackvoxel.com/"
EGIT_REPO_URI="https://github.com/Blackvoxel/Blackvoxel"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/expat
	media-libs/alsa-lib
	media-libs/glew:0
	media-libs/libsdl
	x11-libs/libX11
	virtual/opengl
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e '/COMPILEOPTION_SAVEFOLDERNAME/s:Blackvoxel:.local/share/blackvoxel:' \
		src/ACompileSettings.h || die
	sed -i -e 's/LDFLAGS=/LDFLAGS+= /' -e 's/LDFLAGS/s/-s //' \
		-e '/(CPU_BITS)/ { s/; make //; s/cd/+make -C/}' \
		-e '/CFLAGS+/d' -e 's/CFLAGS=/CFLAGS+=/' Makefile || die
	default
}

src_compile() {
	emake blackvoxeldatadir="/usr/share/${PN}" bindir="/usr/bin"
}

src_install() {
	dodoc Contributors.txt README.md

	dobin blackvoxel
	insinto "/usr/share/${PN}"
	doins -r Misc Sound VoxelTypes gui randomnum.dat
}
