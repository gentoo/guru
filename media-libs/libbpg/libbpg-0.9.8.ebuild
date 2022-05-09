# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Better Portable Graphics reference implementation"
HOMEPAGE="https://bellard.org/bpg/"
SRC_URI="https://bellard.org/bpg/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+x265 bpgview jctvc emcc static-libs"

PATCHES=(
	"${FILESDIR}"/${P}-remove-forced-options.patch
	"${FILESDIR}"/${P}-dont-strip-bins.patch
	"${FILESDIR}"/${P}-add-chost.patch
	"${FILESDIR}"/${P}-add-fpic.patch
)

DEPEND="sys-process/numactl"
RDEPEND="${DEPEND}"
BDEPEND="
	media-video/ffmpeg
	media-libs/libpng
	media-libs/libjpeg-turbo
	bpgview? ( media-libs/sdl-image )
	bpgview? ( media-libs/libsdl )
	dev-lang/yasm
"

src_prepare() {
	default

	cat <<EOF > ${PN}.pc
prefix="${EPREFIX}/usr"
libdir="\${prefix}/$(get_libdir)"
includedir="\${prefix}/include"

Name: ${PN}
Description: ${DESCRIPTION}
URL: ${HOMEPAGE}
Version: ${PV}
Libs: "-L\${libdir}" -lbpg
Cflags: "-I\${includedir}"
EOF

	sed -Ei 's/^(X265_LIBS:=.+\.a)$/\1 -lnuma/' Makefile || die
}

src_compile() {
	emake \
		$(usex x265 USE_X265=y '') \
		$(usex bpgview USE_BPGVIEW=y '') \
		$(usex jctvc USE_JCTVC=y '') \
		$(usex emcc USE_EMCC=y '') \
		CXX="$(tc-getCXX)" \
		CC="$(tc-getCC)"
}

src_install() {
	mkdir -p "${D}"/usr/bin
	emake prefix="${D}"/usr install

	if use bpgview; then
		dobin bpgview
	fi

	if use static-libs; then
		dolib.a libbpg.a
		doheader libbpg.h
		doheader bpgenc.h

		insinto /usr/$(get_libdir)/pkgconfig
		doins ${PN}.pc
	fi
}
