# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A dedicated music player for your Plex media library."
HOMEPAGE="https://www.plex.tv/plexamp/"
SRC_URI="https://plexamp.plex.tv/plexamp.plex.tv/desktop/Plexamp-${PV}.AppImage -> ${P}.AppImage"

S="${WORKDIR}"
# Plex software is licensed under: https://www.plex.tv/about/privacy-legal/plex-terms-of-service/
LICENSE="all-rights-reserved MIT GPL-2 CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"

# Stripping AppImage binaries causes them to no longer recognize their internal
# filesystem.
RESTRICT="strip"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-fs/fuse:0
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

QA_FLAGS_IGNORED="usr/bin/plexamp"

src_install() {
	newbin "${DISTDIR}/${P}.AppImage" plexamp

	# The AppImage is self-contained and is installed as binary directly, but
	# it also contains a `.desktop` file and app icons that we want; we can
	# extract those from its contents.
	"${ED}/usr/bin/plexamp" --appimage-extract || die

	doicon "${S}/squashfs-root/usr/share/icons/hicolor/scalable/plexamp.svg"

	# The inner `.desktop` file points to an internal binary; we can use the
	# file but point it to the installed binary path.
	local menu_path="${S}/squashfs-root/plexamp.desktop"
	sed -ie "s|^Exec=.*$|Exec=${EPREFIX}/usr/bin/plexamp|" "${menu_path}" || die
	domenu "${menu_path}"
}
