# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Zen Browser - A fast, privacy-focused Firefox fork"
HOMEPAGE="https://zen-browser.app/"
SRC_URI="https://github.com/zen-browser/desktop/releases/download/${PV}/zen.linux-x86_64.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}/zen"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
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
"
RDEPEND="${DEPEND}"

inherit desktop xdg-utils

src_install() {
	#create dest dir
	local destdir="/opt/zen"
	insinto "${destdir}"
	doins -r *
	#create a symlink to the binary
	dosym "${destdir}/zen-bin" "/usr/bin/zen" || die
	#add icons
	local size
	for size in 16 32 48 64 128; do
		newicon -s ${size} "browser/chrome/icons/default/default${size}.png" zen.png
	done
	#create desktop file
	make_desktop_entry "/usr/bin/zen" "Zen" zen "Network;WebBrowser"
	#handle permissions of destdir files
	fperms 0755 "${destdir}"/{zen-bin,updater,glxtest,vaapitest}
	fperms 0750 "${destdir}"/pingsender
	# Disable auto-updates
	insinto ${destdir}/distribution
	doins "${FILESDIR}/policies.json"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	elog "For optimal performance and compatibility, please ensure"
	elog "that you have the latest graphics drivers installed."
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
