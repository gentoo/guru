# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial meson

DESCRIPTION="OBS plugin that allows you to screen capture on wlroots based compositors"
HOMEPAGE="https://hg.sr.ht/~scoopta/wlrobs"
EHG_REPO_URI="https://hg.sr.ht/~scoopta/wlrobs"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS=""

IUSE="+dmabuf +scpy"

src_configure() {
	local emesonargs=(
		$(meson_use dmabuf use_dmabuf)
		$(meson_use scpy   use_scpy  )
	)
	meson_src_configure
}

src_install() {
	exeinto "/usr/lib64/obs-plugins"
	doexe "$BUILD_DIR/libwlrobs.so"
}
