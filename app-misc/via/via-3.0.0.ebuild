# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="GUI configurator for supported QMK-based keyboards"
HOMEPAGE="https://caniusevia.com"
SRC_URI="https://github.com/the-via/releases/releases/download/v${PV}/${P}-linux.AppImage -> ${P}.AppImage"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# These dependencies were extracted from the shared libraries required by the
# via-nativia executable; it's not clear whether these are all _actually_
# required, or whether the list is extensive because the executable is an
# Electron app.
RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtk+
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

src_unpack() {
	# The AppImage is self-contained so we'll install it as a binary directly,
	# but it also contains a `.desktop` file and app icons that we want; we can
	# move it into "${S}", and also extract its contents into there.
	mkdir -p "${S}" \
	    && mv "${DISTDIR}/${P}.AppImage" "${S}" \
	    && chmod +x "${S}/${P}.AppImage" \
		&& pushd "${S}" \
	    && "${S}/${P}.AppImage" --appimage-extract \
	    && popd \
		|| die
}

src_install() {
	newbin "${S}/${P}.AppImage" via

	local size
	for size in 16 24 32 48 64 96 128 256 512 1024; do
		doicon -s "${size}" "${S}/squashfs-root/usr/share/icons/hicolor/${size}x${size}/apps/via-nativia.png"
	done

	# The inner `.desktop` file points to an internal binary; we can use the
	# file but point it to the installed binary path.
	local menu_path="${S}/squashfs-root/via-nativia.desktop"
	sed -i '' -e 's|^Exec=.*$|Exec=/usr/bin/via|' "${menu_path}"
	domenu "${menu_path}"
}
