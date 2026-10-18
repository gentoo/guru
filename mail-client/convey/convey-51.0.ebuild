# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION="0.56"

inherit gnome2-utils meson vala virtualx xdg

DESCRIPTION="Email client for GNOME, forked from Geary"
HOMEPAGE="https://gitlab.gnome.org/donnybeelo/convey"

SRC_URI="https://gitlab.gnome.org/donnybeelo/convey/-/archive/${PV}/${P}.tar.bz2"

# LGPL-2.1+ for the code (COPYING), CC-BY-3.0 for the icons (COPYING.icons),
# CC-BY-SA-3.0 for the sound (COPYING.sounds), MIT for the bundled ui/darkreader.js
LICENSE="LGPL-2.1+ CC-BY-3.0 CC-BY-SA-3.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+libunwind test +tnef"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-crypt/gcr-4:4[gtk,vala]
	>=app-crypt/libsecret-0.11[vala]
	>=app-text/enchant-2.1:2
	app-text/iso-codes
	>=dev-db/sqlite-3.24:3
	dev-libs/folks:=
	>=dev-libs/glib-2.80:2
	>=dev-libs/gmime-3.2.4:3.0[vala]
	dev-libs/icu:=
	>=dev-libs/json-glib-1.0
	>=dev-libs/libgee-0.8.5:0.8
	dev-libs/libpeas:2[vala]
	dev-libs/libxml2:=
	dev-libs/snowball-stemmer:=
	>=gui-libs/gtk-4.16.0:4
	>=gui-libs/libadwaita-1.7:1[vala]
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gstreamer:1.0
	net-libs/gnome-online-accounts:=[vala]
	net-libs/libsoup:3.0[vala]
	net-libs/webkit-gtk:6=
	x11-libs/cairo
	libunwind? ( sys-libs/libunwind:= )
	tnef? ( >=net-mail/ytnef-1.9.3 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	dev-libs/appstream
	dev-util/desktop-file-utils
	dev-util/glib-utils
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	test? ( net-libs/gnutls[tools] )
"

src_prepare() {
	vala_setup
	default
}

src_configure() {
	local emesonargs=(
		-Dprofile=release
		-Drevno="${PV}"
		-Dvaladoc=disabled
		-Dcontractor=disabled
		$(meson_feature libunwind)
		$(meson_feature tnef)
	)
	meson_src_configure
}

src_test() {
	# WebKitGTK's bubblewrap sandbox cannot create user namespaces
	# inside Portage's sandbox
	local -x WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1
	virtx meson_src_test
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
