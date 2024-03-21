# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3
EGIT_REPO_URI="https://github.com/mazunki/wl-scripts.git"

DESCRIPTION="A set of utils for wlroots window managers"
HOMEPAGE="https://github.com/mazunki/wl-scripts"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-alternatives/awk
	app-misc/jq
	>=gui-apps/wofi-1.3
	gui-apps/slurp
	gui-wm/sway
"
BDEPEND=""  # scripts are just sh

src_install() {
	exeinto "/usr/bin/"
	doexe "${S}"/src/*
}
