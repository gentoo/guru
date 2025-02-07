# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Graphical UI to help manage Linux overlays."
HOMEPAGE="https://github.com/benjamimgois/goverlay"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/benjamimgois/${PN}.git"
	EGIT3_STORE_DIR="${T}"
else
	SRC_URI="https://github.com/benjamimgois/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-lang/lazarus
"

RDEPEND="
	${DEPEND}
	games-util/mangohud
"

src_prepare() {
	sed -i 's#/usr/local#/usr#g' Makefile || die "Failed to repalace prefix"
	eapply_user
}

src_compile() {
	emake LAZBUILDOPTS="--lazarusdir=/usr/share/lazarus"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
