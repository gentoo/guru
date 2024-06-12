# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="itch.io game browser, installer and launcher"
HOMEPAGE="https://itch.io/"
SRC_URI="https://broth.itch.ovh/itch/linux-amd64/${PV}/archive/default -> ${P}.zip"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="system-ffmpeg"

BDEPEND="app-arch/unzip"
RDEPEND="
	x11-libs/gtk+:3[X,cups]
	x11-libs/libXtst
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/freetype
	x11-libs/pixman
	media-libs/libpng:*
	dev-libs/libpcre
	net-dns/libidn2
	net-libs/gnutls
	dev-libs/libbsd
	sys-apps/util-linux
	media-gfx/graphite2
	media-libs/vulkan-loader
	system-ffmpeg? ( media-video/ffmpeg[chromium] )
"

QA_PREBUILT="
	opt/itch-bin/itch
	opt/itch-bin/libvk_swiftshader.so
	!system-ffmpeg? ( opt/itch-bin/libffmpeg.so )
"

src_install() {
	local destdir="${EPREFIX}/opt/${PN}"
	insinto "${destdir}"
	doins -r locales resources
	doins ./*.pak ./*.dat ./*.bin ./*.json version libvk_swiftshader.so

	if use system-ffmpeg; then	# bug 710944
		rm libffmpeg.so || die
		dosym -r "${EPREFIX}/usr/$(get_libdir)/chromium/libffmpeg.so" \
			${destdir}/libffmpeg.so
	else
		doins libffmpeg.so
	fi

	exeinto "${destdir}"
	doexe itch
	dosym "${destdir}/itch" /usr/bin/itch-bin

	newicon -s 256 "resources/app/src/static/images/tray/itch.png" "${PN}.png"
	newicon -s 128 "resources/app/src/static/images/window/itch/icon.png" "${PN}.png"

	make_desktop_entry itch-bin Itch itch-bin "Network;Game"
}
