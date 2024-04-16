# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake gnome2

DESCRIPTION="A newsreader for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/pan/"
SRC_URI="https://gitlab.gnome.org/GNOME/pan/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/pan-v${PV}"

LICENSE="GPL-2"
SLOT="0"

#cmake broken https://gitlab.gnome.org/GNOME/pan/-/issues/184
KEYWORDS=""
IUSE="dbus gnome-keyring libnotify spell ssl"

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
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWANT_DBUS=$(usex dbus) \
		-DWANT_GKR=$(usex gnome-keyring) \
		-DWANT_GTKSPELL=$(usex spell) \
		-DWANT_NOTIFY=$(usex libnotify) \
		-DWANT_GNUTLS=$(usex ssl)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
}
