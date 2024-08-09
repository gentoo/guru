# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Manager for the Ledger hardware wallet"
HOMEPAGE="https://www.ledger.com/"
SRC_URI="https://download.live.ledger.com/ledger-live-desktop-${PV}-linux-x86_64.AppImage"

S="${WORKDIR}/squashfs-root"

# logos of Ledger are non-free
LICENSE="ledger-live-ToU MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
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

QA_PREBUILT="
	opt/ledger-live/chrome-sandbox
	opt/ledger-live/chrome_crashpad_handler
	opt/ledger-live/ledger-live-desktop
	opt/ledger-live/libEGL.so
	opt/ledger-live/libGLESv2.so
	opt/ledger-live/libffmpeg.so
	opt/ledger-live/libvk_swiftshader.so
	opt/ledger-live/libvulkan.so.1
"

src_unpack() {
	cp "${DISTDIR}"/ledger-live-desktop-${PV}-linux-x86_64.AppImage ${P}.AppImage || die
	chmod +x ${P}.AppImage || die
	./${P}.AppImage --appimage-extract || die
	rm ${P}.AppImage || die
}

src_prepare() {
	default
	sed -e 's/AppRun --no-sandbox/ledger-live/' \
		-e '/X-AppImage-Version/d' \
		-i ledger-live-desktop.desktop || die
}

src_install() {
	exeinto /opt/ledger-live
	doexe chrome{-sandbox,_crashpad_handler} ledger-live-desktop
	insinto /opt/ledger-live
	doins -r *.{bin,dat,json,pak} locales resources lib*
	fperms u+s /opt/ledger-live/chrome-sandbox
	domenu ledger-live-desktop.desktop
	insinto /usr/share
	doins -r usr/share/icons
	dosym -r /opt/ledger-live/ledger-live-desktop /usr/bin/ledger-live
	# bug 937379
	rm "${ED}"/opt/ledger-live/resources/app-update.yml || die
	find "${ED}" -type d -exec chmod 755 {} + || die
}
