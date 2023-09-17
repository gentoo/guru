# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Better Portable Graphics reference implementation"
HOMEPAGE="https://bellard.org/bpg/"
SRC_URI="https://bellard.org/bpg/${P}.tar.gz"

# The BPG decoding library and executable excluding the FFMPEG code as well as
# the BPG Javscript decoder are licensed under the MIT license.
LICENSE="MIT"
# The program bundles several 3rd-party libraries:
#
# The BPG decoding libary and executable use:
# A modified version of FFMPEG - It is stripped of all codecs except HEVC and
# the necessary support code and thus licensed under LGPL-2.1.
# - libavcodec/*
# - libavutil/*
#
# The BPG encoder supports the x265 library and the JCT-VC HEVC reference encoder:
# The modified version of the x265 library - licensed under GPL-2.
# - x265/*
#
# JCT-VC HEVC reference encoder - licensed under the 3-clause BSD license.
# - jctvc/*
LICENSE+=" LGPL-2.1 GPL-2
	jctvc? ( BSD )
"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bpgview jctvc"

PATCHES=(
	"${FILESDIR}"/${P}-add-fpic.patch
	"${FILESDIR}"/${P}-backport-GNU-stack-note-fix.patch
	"${FILESDIR}"/${P}-dont-strip-bins.patch
	"${FILESDIR}"/${P}-fix-implicit-declaration.patch
	"${FILESDIR}"/${P}-remove-forced-options.patch
	"${FILESDIR}"/${P}-remove-unused-cmake-var.patch
	"${FILESDIR}"/${P}-respect-compiler-driver.patch
	"${FILESDIR}"/${P}-respect-user-flags.patch
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
	tc-export AR CC CXX
	emake \
		USE_X265=y \
		$(usex bpgview USE_BPGVIEW=y '') \
		$(usex jctvc USE_JCTVC=y '')
}

src_install() {
	mkdir -p "${ED}"/usr/bin || die
	# We never called configure with --prefix="${EPREFIX}"/usr or similar
	emake prefix="${ED}"/usr install
	einstalldocs

	if use bpgview; then
		dobin bpgview
	fi

	dolib.a libbpg.a
	doheader libbpg.h bpgenc.h

	insinto /usr/$(get_libdir)/pkgconfig
	doins ${PN}.pc
}
