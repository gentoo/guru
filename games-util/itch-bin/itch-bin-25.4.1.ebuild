# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="itch.io game browser, installer and launcher"
HOMEPAGE="https://itch.io/"
SRC_URI="https://broth.itch.ovh/itch/linux-amd64/${PV}/archive/default -> ${P}.zip"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

BDEPEND="|| ( app-arch/zip app-arch/unzip )"
RDEPEND="
	x11-libs/gtk+:3[X,cups]
	gnome-base/gconf
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
"

QA_PREBUILT="
	/opt/itch-bin/itch
	/opt/itch-bin/libffmpeg.so
	/opt/itch-bin/libnode.so
"

S="${WORKDIR}"

src_install() {
	local destdir="${EPREFIX}/opt/${PN}"
	insinto "${destdir}"
	doins -r locales resources
	doins *.pak *.dat *.bin libffmpeg.so

	exeinto "${destdir}"
	doexe itch
	dosym "${destdir}/itch" /usr/bin/itch-bin

	doicon -s 512 "${FILESDIR}/itch-bin.png"
	make_desktop_entry itch-bin Itch itch-bin Network
}
