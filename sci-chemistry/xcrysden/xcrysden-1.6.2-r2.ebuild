# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop flag-o-matic toolchain-funcs xdg

DESCRIPTION="For the visualisation of molecular and crystal structures."

HOMEPAGE="http://www.xcrysden.org/"

SRC_URI="http://www.xcrysden.org/download/${P}.tar.gz"

LICENSE="GPL-2+"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	>=x11-base/xorg-server-21.1.4
	>=virtual/glu-9.0-r2
	>=dev-lang/tcl-8.6.12:=
	>=dev-lang/tk-8.6.12:=
	>=dev-tcltk/togl-2.0-r3
	>=dev-tcltk/bwidget-1.9.14
	media-libs/libglvnd[X]
	sci-libs/fftw:3.0=
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-ext-bwidget.patch"
	"${FILESDIR}/${P}-LDFLAGS.patch"
	"${FILESDIR}/${P}-Togl-lib.patch"
	"${FILESDIR}/${P}-wrapper-paths.patch"
	"${FILESDIR}/${P}-c23.patch"
)

src_prepare() {
	default
	cp "${S}/system/Make.sys-shared" "${S}/Make.sys" || die 'Copying Make.sys to build dir failed.'

	# fix doc install path
	sed -e "s|share/doc/\$(xcrysden)|share/doc/${PF}|" \
		-e "/ln -sf .*doc/d" \
		-e "/gzip/d" \
		-i Makefile || die
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

	domenu "${FILESDIR}/${PN}.desktop"
	doicon -s 32x32 "${FILESDIR}/icons/${PN}.png"
	docompress -x /usr/share/doc/${PF}/examples
}
