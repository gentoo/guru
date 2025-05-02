# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg

DESCRIPTION="A beautiful, fast and fully open source mail client for Mac, Windows and Linux"
HOMEPAGE="https://getmailspring.com/"
SRC_URI="https://github.com/Foundry376/Mailspring/releases/download/${PV}/mailspring-${PV}-amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+wayland"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/mit-krb5
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gvfs
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	dev-build/libtool
	sys-libs/db:5.3
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="*"

src_unpack(){
	unpack_deb ${A}
}

src_install(){
	if use wayland; then
		sed -i "s|Exec=mailspring %U|Exec=mailspring --ozone-platform-hint=auto --enable-wayland-ime %U|g" \
			"${S}/usr/share/applications/Mailspring.desktop" || die
	fi

	cp -R "${S}"/* "${D}" || die "Installing binary files failed"
	mv "${D}/usr/share/doc/mailspring" "${D}/usr/share/doc/${PF}" || die
	mv "${D}/usr/share/appdata" "${D}/usr/share/metainfo" || die
}
