# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A set of utils for wlroots window managers"
HOMEPAGE="https://github.com/mazunki/wl-scripts"
SRC_URI="https://github.com/mazunki/wl-scripts/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-alternatives/awk
	app-misc/jq
	>=gui-apps/wofi-1.3
	gui-apps/slurp
	gui-libs/wlroots
"

src_install() {
	exeinto "/usr/bin/"
	doexe "${S}"/src/*
}
