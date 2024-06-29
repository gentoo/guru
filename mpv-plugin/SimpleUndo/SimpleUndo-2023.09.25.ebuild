# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

DESCRIPTION="Ctrl-Z return to the previous seekbar position, Ctrl-Z again redo"
HOMEPAGE="https://github.com/Eisa01/mpv-scripts#simpleundo"
SRC_URI="https://github.com/Eisa01/mpv-scripts/archive/refs/tags/25-09-2023.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mpv-scripts-25-09-2023"

LICENSE="BSD-2"
KEYWORDS="~amd64"

MPV_PLUGIN_FILES=(
	SimpleUndo.lua
)

src_prepare() {
	mv scripts/SimpleUndo.lua .

	default
}

pkg_postinst() {
	mpv-plugin_pkg_postinst
	einfo "Ctrl-Z to jump back (undo) and forth (redo)"
}
