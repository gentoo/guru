# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Reverse-engineered Minecraft Classic client"
HOMEPAGE="https://www.classicube.net/"
EGIT_REPO_URI="https://github.com/UnknownShadow200/ClassiCube"
EGIT_COMMIT="${PV}"

LICENSE="BSD MIT FTL"
SLOT="0"

DEPEND="x11-libs/libX11 x11-libs/libXi virtual/opengl"
RDEPEND="${DEPEND}"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} src/*.c -o ClassiCube -rdynamic -lm -lpthread -lX11 -lXi -lGL -ldl || die
}

src_install() {
	exeinto "/usr/libexec"
	doexe ClassiCube
	dobin "${FILESDIR}/ClassiCube"
	dodoc readme.md
	dodoc doc/*.md
}
