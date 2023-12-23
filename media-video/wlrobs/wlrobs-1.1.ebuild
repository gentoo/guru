# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [ "${PV}" == 9999 ]
then
	inherit mercurial
	EHG_REPO_URI="https://hg.sr.ht/~scoopta/wlrobs"
else
	SRC_URI="https://hg.sr.ht/~scoopta/wlrobs/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="OBS plugin that allows you to screen capture on wlroots based compositors"
HOMEPAGE="https://hg.sr.ht/~scoopta/wlrobs"

LICENSE="GPL-3"

SLOT="0"

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
