# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools gnome2

DESCRIPTION="A newsreader for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/pan/"
SRC_URI="https://gitlab.gnome.org/GNOME/pan/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/pan-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="dbus gnome-keyring libnotify nls spell ssl"

DEPEND="
	>=dev-libs/glib-2.26:2
	dev-libs/gmime:3.0
	>=x11-libs/gtk+-3.00:3
	gnome-keyring? (
		>=app-crypt/gcr-3.20
		>=app-crypt/libsecret-0.20
	)
	libnotify? ( >=x11-libs/libnotify-0.4.1:0= )
	spell? (
		>=app-text/enchant-2.2.3:2
		>=app-text/gtkspell-3.0.10:3 )
	ssl? ( >=net-libs/gnutls-3:0= )
	>=sys-libs/zlib-1.2.0
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/yelp-tools
	>=sys-devel/gettext-0.19.7
	virtual/pkgconfig
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_with dbus) \
		$(use_enable gnome-keyring gkr) \
		$(use_enable nls) \
		$(use_with spell gtkspell) \
		$(use_enable libnotify) \
		$(use_with ssl gnutls)
	)

	gnome2_src_configure "${myconf[@]}"
}
