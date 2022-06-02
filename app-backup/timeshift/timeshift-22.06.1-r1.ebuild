# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature toolchain-funcs vala xdg

DESCRIPTION="A system restore utility for Linux"
HOMEPAGE="https://github.com/linuxmint/timeshift"
SRC_URI="https://github.com/linuxmint/${PN}/archive/v${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:=
	net-libs/libsoup:2.4
	media-libs/harfbuzz:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/pango
	x11-libs/xapp
	x11-libs/vte:2.91[vala]
"
RDEPEND="${DEPEND}
	net-misc/rsync
	virtual/cron
"
BDEPEND="
	$(vala_depend)
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}"/${P}-makefile.patch )

src_prepare() {
	default
	vala_setup
}

src_compile() {
	tc-export CC
	emake all
	emake manpage
}

src_install() {
	emake prefix="${EPREFIX}"/usr sysconfdir="${EPREFIX}"/etc install DESTDIR="${D}"
	einstalldocs
}

pkg_postinst() {
	optfeature "btrfs support" sys-fs/btrfs-progs
}
