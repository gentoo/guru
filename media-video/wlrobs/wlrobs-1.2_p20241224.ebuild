# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

COMMIT="b8668b4d6d6d33e3de86ce3fa4331249bc0abc8b"

DESCRIPTION="OBS plugin that allows you to screen capture on wlroots based compositors"
HOMEPAGE="https://hg.sr.ht/~scoopta/wlrobs"
SRC_URI="https://hg.sr.ht/~scoopta/wlrobs/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	dev-libs/wayland
	media-video/obs-studio
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		-Duse_dmabuf=true
		-Duse_scpy=true
	)
	meson_src_configure
}
