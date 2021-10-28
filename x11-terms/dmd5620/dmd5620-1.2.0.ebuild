# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs xdg-utils

DESCRIPTION="GTK+ 3.0 implementation of an AT&T / Teletype DMD 5620 emulator."
HOMEPAGE="https://github.com/sethm/dmd_gtk"
SRC_URI="https://github.com/sethm/dmd_gtk/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dmd_gtk-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test mirror"

RDEPEND="
	net-libs/libtelnet
	dev-libs/dmd_core
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf
	x11-libs/cairo
	dev-libs/glib:2
"
DEPEND="${RDEPEND}"

BDEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	# remove bundled libraries
	rm "${S}"/src/libtelnet.c "${S}"/src/libtelnet.h "${S}"/lib/libdmd_core.a || die "failed to remove bundled libraries"
	rmdir "${S}"/lib
	# apply patches
	eapply "${FILESDIR}/${PN}-1.2.0-systemlibs-nostrip.patch"
	eapply_user
	# use system pkgconfig
	sed -i -e "s:pkgconfig:$(tc-getPKG_CONFIG):" "${S}"/Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getLD)"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
	dodoc "${S}/LICENSE.md"
	dodoc "${S}/README.md"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
