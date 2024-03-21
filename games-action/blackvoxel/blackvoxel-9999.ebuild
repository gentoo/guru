# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Blackvoxel Video Game"
HOMEPAGE="https://www.blackvoxel.com/"
EGIT_REPO_URI="https://github.com/Blackvoxel/Blackvoxel"

LICENSE="GPL-3"
SLOT="0"

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
	sed -i -e 's/LDFLAGS=/LDFLAGS+= /' -e '/LDFLAGS/s/-s -zrelro //' \
		-e '/(CPU_BITS)/ { s/; make //; s/cd/+make -C/}' \
		-e '/CFLAGS+/d' -e 's/CFLAGS=/CFLAGS+=/' \
		-e '/^CC=/d' -e 's/^LD=/CXX?=/' \
		-e 's/CFLAGS/CXXFLAGS/g' -e 's/\$(CC)/$(CXX)/' \
		-e 's/\$(LD)/$(CXX)/' \
		Makefile || die
	sed -i -e 's/\<gcc\>/$(CC)/' -e 's/\<g++ /$(CXX) /' \
		-e 's/\<ar\>/$(AR)/' src/sc_Squirrel3/squirrel/Makefile \
		src/sc_Squirrel3/sqstdlib/Makefile \
		src/sc_Squirrel3/sq/Makefile || die
	default
}

src_compile() {
	export CXX="$(tc-getCXX)"
	export CC="$(tc-getCC)"
	export AR="$(tc-getAR)"

	emake blackvoxeldatadir="/usr/share/${PN}" bindir="/usr/bin"
}

src_install() {
	dodoc Contributors.txt README.md

	dobin blackvoxel
	insinto "/usr/share/${PN}"
	doins -r Misc Sound VoxelTypes gui randomnum.dat
}
