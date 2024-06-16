# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="🍭 Sweet gradient icons"
HOMEPAGE="https://github.com/EliverLara/candy-icons"
EGIT_REPO_URI="https://github.com/EliverLara/candy-icons.git"

LICENSE="GPL-3"
SLOT="0"

src_install() {
	default

	insinto "/usr/share/icons/${PN}"
	rm -rf "${S}"/{.git,.github,preview} || die "Could not remove useless directories"
	doins -r "${S}"/*
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
