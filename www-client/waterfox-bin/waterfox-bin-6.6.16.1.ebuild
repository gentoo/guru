# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

MY_PN="waterfox"

DESCRIPTION="A privacy-focused, performance-oriented browser based on Firefox"
HOMEPAGE="https://www.waterfox.com/"
SRC_URI="https://cdn.waterfox.com/waterfox/releases/${PV}/Linux_x86_64/waterfox-${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${MY_PN}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="strip"
QA_PREBUILT="*"

RDEPEND="${DEPEND}
	!www-client/firefox-bin:0
	|| (
		media-libs/libpulse
		media-sound/apulse
	)
	>=app-accessibility/at-spi2-core-2.46.0:2
	>=dev-libs/glib-2.26:2
	media-libs/alsa-lib
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	media-video/ffmpeg
	sys-apps/dbus
	virtual/freedesktop-icon-theme
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.11:3[X]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxcb
	>=x11-libs/pango-1.22.0
"

src_install() {
	#create dest dir
	local destdir="/opt/waterfox"
	insinto "${destdir}"
	doins -r *
	#create a symlink to the binary
	dosym -r "${destdir}/waterfox-bin" "/usr/bin/waterfox" || die
	#add icons
	local size
	for size in 16 32 48 64 128; do
		newicon -s ${size} "browser/chrome/icons/default/default${size}.png" waterfox.png
	done
	#create desktop file
	make_desktop_entry "/usr/bin/Waterfox" "Waterfox" waterfox "Network;WebBrowser" "$(cat "${FILESDIR}"/desktop_options)"
	#handle permissions of destdir files
	fperms 0755 "${destdir}"/{waterfox-bin,updater,glxtest,vaapitest}
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
