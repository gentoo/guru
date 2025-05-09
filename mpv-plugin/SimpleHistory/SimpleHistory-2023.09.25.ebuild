# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

DESCRIPTION="Continue watching last played, manage and play from history"
HOMEPAGE="https://github.com/Eisa01/mpv-scripts#simpleundo"

V_Y=${PV%%.*}
V_M=${PV#*.}
V_M=${V_M%%.*}
V_D=${PV##*.}

MY_PV="${V_D}-${V_M}-${V_Y}"
SRC_URI="https://github.com/Eisa01/mpv-scripts/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mpv-scripts-${MY_PV}"

LICENSE="BSD-2"
KEYWORDS="~amd64"

MPV_PLUGIN_FILES=(
	SimpleHistory.lua
)

DOCS=(
	script-opts/SimpleHistory.conf
	README.md
)

src_prepare() {
	mv scripts/SimpleHistory.lua . || die

	default
}

pkg_postinst() {
	mpv-plugin_pkg_postinst
	einfo "h to see the history, ctrl-r to resume previously closed"
	einfo "Documentation https://github.com/Eisa01/mpv-scripts#simplehistory"
}
