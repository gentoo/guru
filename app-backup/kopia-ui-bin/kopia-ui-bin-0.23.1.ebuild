# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Kopia - Fast And Secure Open-Source Backup (Electron UI)"
HOMEPAGE="https://github.com/kopia/kopia"

SRC_URI="
	amd64? ( https://github.com/kopia/kopia/releases/download/v${PV}/kopia-ui_${PV}_amd64.deb -> ${P}-amd64.deb )
	arm? ( https://github.com/kopia/kopia/releases/download/v${PV}/kopia-ui_${PV}_armv7l.deb -> ${P}-arm.deb )
	arm64? ( https://github.com/kopia/kopia/releases/download/v${PV}/kopia-ui_${PV}_arm64.deb -> ${P}-arm64.deb )
"

S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64"
IUSE="+system-kopia"

# binary package; no tests available
RESTRICT="test"

RDEPEND="
	system-kopia? ( ~app-backup/kopia-${PV} )
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-apps/systemd-utils
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

QA_PREBUILT="opt/KopiaUI/*"

src_install() {
	mv "${S}"/* "${ED}" || die
	mkdir -p "${ED}/usr/bin/" || die
	ln -sf "${EPREFIX}/opt/KopiaUI/kopia-ui" "${ED}/usr/bin/kopia-ui" || die

	if use system-kopia; then
		rm -f "${ED}/opt/KopiaUI/resources/server/kopia" || die
		ln -sf "${EPREFIX}/usr/bin/kopia" "${ED}/opt/KopiaUI/resources/server/kopia" || die
	fi

	# The only doc bundled here is a `/usr/share/doc/kopia-ui/changelog.gz`.
	#
	# This fails QA for two reasons:
	# 1. Gentoo expects `/usr/share/doc/${P}`
	# 2. `/usr/share/doc` is subject to automatic compression, so Portage
	#    expects files installed to not be compressed
	#
	# We could decompress archives in this directory and move them to the right
	# place, but for a changelog, not really worth it.
	rm -rf "${ED}/usr/share/doc/kopia-ui" || die
}
