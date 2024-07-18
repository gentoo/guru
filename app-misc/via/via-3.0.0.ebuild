# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="GUI configurator for supported QMK-based keyboards"
HOMEPAGE="https://www.caniusevia.com/"
SRC_URI="https://github.com/the-via/releases/releases/download/v${PV}/${P}-linux.AppImage -> ${P}.AppImage"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Stripping AppImage binaries causes them to no longer recognize their internal
# filesystem.
RESTRICT="strip"

# Except for sys-libs/zlib, these dependencies were extracted from the shared
# libraries required by the via-nativia executable; it's not clear whether
# these are all _actually_ required, or whether the list is extensive because
# the executable is an Electron app.
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

QA_FLAGS_IGNORED="usr/bin/via"

src_install() {
	newbin "${DISTDIR}/${P}.AppImage" via

	# The AppImage is self-contained and is installed as a binary directly, but
	# it also contains a `.desktop` file and app icons that we want; we can
	# extract those from its contents.
	"${ED}/usr/bin/via" --appimage-extract || die

	local size
	for size in 16 24 32 48 64 96 128 256 512 1024; do
		doicon -s "${size}" "${S}/squashfs-root/usr/share/icons/hicolor/${size}x${size}/apps/via-nativia.png"
	done

	# The inner `.desktop` file points to an internal binary; we can use the
	# file but point it to the installed binary path.
	local menu_path="${S}/squashfs-root/via-nativia.desktop"
	sed -ie "s|^Exec=.*$|Exec=${EPREFIX}/usr/bin/via|" "${menu_path}" || die
	domenu "${menu_path}"
}
