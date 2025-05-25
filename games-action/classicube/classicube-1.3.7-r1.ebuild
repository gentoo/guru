# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit prefix

DESCRIPTION="Reverse-engineered Minecraft Classic client"
HOMEPAGE="https://www.classicube.net/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ClassiCube/ClassiCube.git"
else
	SRC_URI="https://github.com/ClassiCube/ClassiCube/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/ClassiCube-${PV}"

	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc ~sparc ~x86"
fi

LICENSE="BSD MIT FTL"
SLOT="0"

DEPEND="x11-libs/libX11 x11-libs/libXi virtual/opengl"
RDEPEND="${DEPEND}"

src_prepare() {
	# Makefile provides EXTRA_CFLAGS but no EXTRA_LDFLAGS
	sed -e 's/$(CC) $(LDFLAGS)/& $(EXTRA_LDFLAGS)/' \
		-i Makefile || die
	default
}

src_compile() {
	emake \
		EXTRA_CFLAGS="-Wno-error ${CPPFLAGS} ${CFLAGS}" \
		EXTRA_LDFLAGS="${LDFLAGS}"
}

src_install() {
	cp "${FILESDIR}/ClassiCube-r1" "${T}/ClassiCube" || die
	eprefixify "${T}/ClassiCube"

	exeinto /usr/libexec
	doexe ClassiCube
	dobin "${T}/ClassiCube"
	dodoc readme.md
	dodoc doc/*.md
}
