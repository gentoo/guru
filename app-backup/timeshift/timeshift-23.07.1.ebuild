# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature meson vala xdg

DESCRIPTION="A system restore utility for Linux"
HOMEPAGE="https://github.com/linuxmint/timeshift"
SRC_URI="https://github.com/linuxmint/${PN}/archive/${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	x11-libs/gtk+:3
	dev-libs/json-glib
	x11-libs/vte:2.91[vala]
	>=dev-libs/libgee-0.18.0:=
	>=x11-libs/xapp-1.0.4
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
"
RDEPEND="${DEPEND}
	virtual/cron
"
BDEPEND="
	$(vala_depend)
	virtual/pkgconfig
	sys-apps/help2man
"

src_prepare() {
	default
	vala_setup
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "btrfs support" sys-fs/btrfs-progs
	optfeature "rsync support"	net-misc/rsync
}

pkg_postrm() {
	xdg_pkg_postrm
}
