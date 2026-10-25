# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop flag-o-matic toolchain-funcs xdg

DESCRIPTION="For the visualisation of molecular and crystal structures"
HOMEPAGE="http://www.xcrysden.org/"
SRC_URI="http://www.xcrysden.org/download/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-lang/tcl:0/8.6
	dev-lang/tk:0/8.6
	dev-tcltk/bwidget
	>=dev-tcltk/togl-2.0
	sci-libs/fftw:3.0=
	x11-libs/libX11
	virtual/glu
	virtual/opengl[X]"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-accumulation-buffer.patch"
	"${FILESDIR}/${P}-c23.patch"
	"${FILESDIR}/${P}-ext-bwidget.patch"
	"${FILESDIR}/${P}-LDFLAGS.patch"
	"${FILESDIR}/${P}-Togl-lib.patch"
	"${FILESDIR}/${P}-wrapper-paths.patch"
)

src_prepare() {
	default

	cp system/Make.sys-shared Make.sys || die 'Copying Make.sys to build dir failed.'

	# fix doc install path
	sed -e "s|share/doc/\$(xcrysden)|share/doc/${PF}|" \
		-e "/ln -sf .*doc/d" \
		-e "/gzip/d" \
		-i Makefile || die 'Failed to set correct doc install path'
}

src_compile() {
	append-cflags "-fcommon"

	emake xcrysden \
		CC="$(tc-getBUILD_CC)" \
		FC="$(tc-getFC)"
}

src_install() {
	emake \
		prefix="${ED}"/usr \
		install

	doicon -s 32x32 "${FILESDIR}/icons/${PN}.png"

	make_desktop_entry "xcrysden" \
					   "XCrySDen" \
					   "xcrysden" \
					   "Science;"

	docompress -x /usr/share/doc/${PF}/examples
}
