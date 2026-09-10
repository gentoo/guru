# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="A traditional roguelike dungeon crawler"
HOMEPAGE="https://shatteredpixel.com/shatteredpd/"
SRC_URI="https://github.com/00-Evan/shattered-pixel-dungeon/releases/download/v${PV}/${PN}-v${PV}-Java.jar"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-21:*"
DEPEND="${RDEPEND}"

IDEPEND="dev-util/desktop-file-utils
		 dev-util/gtk-update-icon-cache"

src_install() {
	# Install all icons
	local x
	for x in 16 32 48 64 128 256; do
		newicon -s ${x} icons/icon_${x}.png ${PN}.png
	done

	insinto /opt/${PN}-${SLOT}/lib
	doins "${DISTDIR}/${PN}-v${PV}-Java.jar"
	make_desktop_entry "java -jar /opt/${PN}-${SLOT}/lib/${PN}-v${PV}-Java.jar" "${PN}" "${PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
