# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="A social network off the grid with append-only protocol (no edits) on blockchain"
HOMEPAGE="https://www.manyver.se/"

SRC_URI="https://github.com/staltz/manyverse/releases/download/v${PV}-beta/manyverse_${PV}-beta_amd64.deb"
S="${WORKDIR}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

src_prepare() {
	rm -rf usr/share/doc/
	# Because only changelog.gz here with a few lines, and need to be unpacked

	default
}

src_install() {
	insinto /
	doins -r .

	fperms +x /opt/Manyverse/manyverse
	dosym /opt/Manyverse/manyverse /usr/bin/${PN}
}

pkg_postinst() {

	xdg_desktop_database_update

	xdg_icon_cache_update
}
