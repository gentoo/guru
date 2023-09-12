# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit desktop unpacker xdg

DESCRIPTION="HTTP and GraphQL client for developers"
HOMEPAGE="https://insomnia.rest"
SRC_URI="https://github.com/Kong/${MY_PN}/releases/download/core@${PV}/Insomnia.Core-${PV}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fontconfig cups alsa dbus accessibility"

RDEPEND="
	dev-libs/glib
	dev-libs/nss
	dev-libs/nspr
	app-accessibility/at-spi2-core
	x11-libs/libdrm
	x11-libs/gtk+
	x11-libs/pango
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	media-libs/mesa
	dev-libs/expat
	x11-libs/libxcb
	x11-libs/libxkbcommon
	sys-devel/gcc
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	dbus? ( sys-apps/dbus )
	fontconfig? ( media-libs/fontconfig:1.0 )
	accessibility? ( app-accessibility/at-spi2-core )
"

S="$WORKDIR"

src_install() {
	for size in 16x16 32x32 48x48 128x128 256x256 512x512 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}"/apps/insomnia.png
	done
	dosym ../icons/hicolor/512x512/apps/insomnia.png \
		/usr/share/pixmaps/insomnia.png

	domenu usr/share/applications/insomnia.desktop

	insinto /opt/Insomnia
	doins -r opt/Insomnia/.
	fperms +x /opt/Insomnia/insomnia
	fperms +x /opt/Insomnia/chrome_crashpad_handler
	dosym ../Insomnia/insomnia opt/bin/insomnia
}
