# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature toolchain-funcs vala xdg

DESCRIPTION="A system restore utility for Linux"
HOMEPAGE="https://github.com/linuxmint/timeshift"
SRC_URI="https://github.com/linuxmint/${PN}/archive/${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

DEPEND="
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/json-glib
	>=dev-libs/libgee-0.18.0:=
	net-libs/libsoup:2.4
	media-libs/harfbuzz:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/pango
	>=x11-libs/xapp-1.0.4
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

PATCHES=( "${FILESDIR}"/${PN}-22.11.1-build-system.patch )

src_prepare() {
	default
	vala_setup
}

src_compile() {
	tc-export CC
	if use gtk; then
		# can't use all jobs here, fails to compile because some files getting removed
		# during compilation, which are missing afterwards.
		# https://bugs.gentoo.org/883157
		# Pascal Jäger <pascal.jaeger@leimstift.de> (2022-11-26)
		emake -j1
	else
		emake app-console -j1
	fi
	emake manpage
}

src_install() {
	if use gtk; then
		emake INSTALL_GTK=true prefix="${EPREFIX}"/usr sysconfdir="${EPREFIX}"/etc install DESTDIR="${D}"
	else
		emake INSTALL_GTK=false prefix="${EPREFIX}"/usr sysconfdir="${EPREFIX}"/etc install DESTDIR="${D}"
	fi
	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst
	if ! use gtk; then
		elog ""
		elog "Installed timeshift without gtk GUI."
		elog "If you need the gtk GUI emerge timeshift"
		elog "with USE=\"gtk\""
	fi
	optfeature "btrfs support" sys-fs/btrfs-progs
}

pkg_postrm() {
	xdg_pkg_postrm
}
