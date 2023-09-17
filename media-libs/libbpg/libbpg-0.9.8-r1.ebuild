# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Better Portable Graphics reference implementation"
HOMEPAGE="https://bellard.org/bpg/"
SRC_URI="https://bellard.org/bpg/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bpgview jctvc"

PATCHES=(
	"${FILESDIR}"/${P}-remove-forced-options.patch
	"${FILESDIR}"/${P}-dont-strip-bins.patch
	"${FILESDIR}"/${P}-add-chost.patch
	"${FILESDIR}"/${P}-add-fpic.patch
)

# Libnuma is a dependency of the default (x265) encoder.
DEPEND="
	media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	sys-process/numactl
	bpgview? (
				media-libs/sdl-image
				media-libs/libsdl
			 )
"
RDEPEND="${DEPEND}"
# Strictly speaking, these are the default (x265) encoder's build time
# dependencies.
BDEPEND="
	dev-lang/yasm
	dev-util/cmake
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
		USE_X265=y \
		$(usex bpgview USE_BPGVIEW=y '') \
		$(usex jctvc USE_JCTVC=y '') \
		CXX="$(tc-getCXX)" \
		CC="$(tc-getCC)"
}

src_install() {
	mkdir -p "${D}"/usr/bin
	emake prefix="${D}"/usr install

	if use bpgview; then
		dobin bpgview
	fi

	dolib.a libbpg.a
	doheader libbpg.h
	doheader bpgenc.h

	insinto /usr/$(get_libdir)/pkgconfig
	doins ${PN}.pc
}
