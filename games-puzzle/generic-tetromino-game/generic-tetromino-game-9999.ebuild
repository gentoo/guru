# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Faithful clone of NES Tetris but with new features and mods API"
HOMEPAGE="https://generic-tetromino-game.sebsite.pw/"
EGIT_REPO_URI="https://git.sr.ht/~sebsite/generic-tetromino-game"
# GPL-3: Engine
# all-right-reserved:
# - Sound effects extracted from NES Tetris
# - Tiles if copyrightable
# - SiIvaGunner rips
LICENSE="GPL-3 all-rights-reserved"
SLOT="0"

# Note: Lua version is hardcoded
RDEPEND="
	dev-lang/lua:5.4
	media-libs/libsdl2
	media-libs/sdl2-mixer
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" install
}
