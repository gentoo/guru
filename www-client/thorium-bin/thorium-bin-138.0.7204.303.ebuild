# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI=8

inherit desktop pax-utils xdg-utils unpacker

DESCRIPTION="The fastest browser on Earth - Chromium fork (Binary Version)"
HOMEPAGE="https://thorium.rocks/"

MY_PV="138.0.7204.303"
BASE_URL="https://github.com/Alex313031/thorium/releases/download/M${MY_PV}"

SRC_URI="
	cpu_flags_x86_avx2? ( ${BASE_URL}/thorium-browser_${MY_PV}_AVX2.deb )
	cpu_flags_x86_avx? ( !cpu_flags_x86_avx2? ( ${BASE_URL}/thorium-browser_${MY_PV}_AVX.deb ) )
	cpu_flags_x86_sse3? ( !cpu_flags_x86_avx2? ( !cpu_flags_x86_avx? ( ${BASE_URL}/thorium-browser_${MY_PV}_SSE3.deb ) ) )
"

S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="cpu_flags_x86_avx2 cpu_flags_x86_avx cpu_flags_x86_sse3"

REQUIRED_USE="|| ( cpu_flags_x86_avx2 cpu_flags_x86_avx cpu_flags_x86_sse3 )"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	default
	rm -rf etc/ cron/ usr/share/doc/ || die
}

src_install() {
	insinto /opt/thorium-browser
	doins -r opt/chromium.org/thorium/*

	fperms 4755 /opt/thorium-browser/chrome-sandbox
	fperms 0755 /opt/thorium-browser/thorium
	fperms 0755 /opt/thorium-browser/thorium-browser
	fperms 0755 /opt/thorium-browser/thorium_shell

	dosym ../../opt/thorium-browser/thorium /usr/bin/thorium-browser

	domenu usr/share/applications/thorium-browser.desktop
	doman usr/share/man/man1/thorium-browser.1.gz

	local size
	for size in 16 24 32 48 64 128 256; do
		if [[ -f "opt/chromium.org/thorium/product_logo_${size}.png" ]]; then
			newicon -s ${size} "opt/chromium.org/thorium/product_logo_${size}.png" thorium-browser.png
		fi
	done

	sed -i 's|Exec=/usr/bin/thorium-browser|Exec=thorium-browser|g' \
		"${ED}/usr/share/applications/thorium-browser.desktop" || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
