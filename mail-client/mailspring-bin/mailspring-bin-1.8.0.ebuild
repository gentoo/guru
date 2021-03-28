# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="A beautiful, fast and fully open source mail client for Mac, Windows and Linux."

HOMEPAGE="https://getmailspring.com/"

SRC_URI="https://github.com/Foundry376/Mailspring/releases/download/${PV}/mailspring-${PV}-amd64.deb"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~amd64"

IUSE=""

RDEPEND="
	app-crypt/libsecret
	gnome-base/gconf
	>=x11-libs/gtk+-3
	virtual/udev
	dev-libs/libgcrypt
	x11-libs/libnotify
	x11-libs/libXtst
	x11-libs/libxkbfile
	dev-libs/nss
	sys-devel/libtool
	net-dns/c-ares
	dev-cpp/ctemplate
	app-text/tidy-html5
	|| ( gnome-base/gvfs =dev-libs/glib-2* )
	x11-misc/xdg-utils
	media-libs/libglvnd
"

S="${WORKDIR}"

src_unpack(){
	unpack_deb ${A}
}

src_install(){
	cp -R "${S}"/* "${D}" || die "Installing binary files failed"
}
