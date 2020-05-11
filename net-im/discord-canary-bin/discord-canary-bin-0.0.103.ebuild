# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg

DESCRIPTION="All-in-one voice and text chat"

HOMEPAGE="https://discordapp.com/"

SRC_URI="https://dl-canary.discordapp.net/apps/linux/${PV}/discord-canary-${PV}.tar.gz"
RESTRICT="mirror bindist"
KEYWORDS="~amd64"

SLOT="0"
LICENSE="all-rights-reserved"
RDEPEND=""
DEPEND="${RDEPEND}
	dev-libs/atk
	sys-libs/libcxx
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gconf:2
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig:1.0
	media-libs/libpng
	media-libs/freetype:2
	net-print/cups
	sys-apps/dbus
	net-libs/gnutls
	sys-libs/libcxx
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	sys-libs/zlib
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango

	x11-libs/libXtst
	media-libs/opus"

S=${WORKDIR}/DiscordCanary

QA_PREBUILT="
	opt/discord-canary-bin/DiscordCanary
	opt/discord-canary-bin/libEGL.so
	opt/discord-canary-bin/libGLESv2.so
	opt/discord-canary-bin/swiftshader/libEGL.so
	opt/discord-canary-bin/swiftshader/libGLESv2.so
	opt/discord-canary-bin/libVkICD_mock_icd.so
	opt/discord-canary-bin/libffmpeg.so
"

src_install() {
	local destdir="/opt/${PN}"

	insinto $destdir
	doins -r locales resources
	doins \
		*.pak \
		*.png \
		*.dat \
		*.bin \
		*.so

	exeinto $destdir
	doexe DiscordCanary

	dosym $destdir/DiscordCanary /usr/bin/discord-canary
	make_desktop_entry discord Discord \
		"/opt/discord-canary/discord.png" \
		Network
}
