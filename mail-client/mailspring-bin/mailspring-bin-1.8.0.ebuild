# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="A beautiful, fast and fully open source mail client for Mac, Windows and Linux"
HOMEPAGE="https://getmailspring.com/"
SRC_URI="https://github.com/Foundry376/Mailspring/releases/download/${PV}/mailspring-${PV}-amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"


RDEPEND="
	app-crypt/libsecret
	app-text/tidy-html5
	dev-cpp/ctemplate
	dev-libs/libgcrypt
	dev-libs/nss
	gnome-base/gconf
	media-libs/libglvnd
	net-dns/c-ares
	sys-devel/libtool
	virtual/udev
	=x11-libs/gtk+-3*
	x11-libs/libnotify
	x11-libs/libxkbfile
	x11-libs/libXtst
	x11-misc/xdg-utils
	|| ( =dev-libs/glib-2* gnome-base/gvfs  )
"

src_unpack(){
	unpack_deb ${A}
}

src_install(){
	cp -R "${S}"/* "${D}" || die "Installing binary files failed"
}
