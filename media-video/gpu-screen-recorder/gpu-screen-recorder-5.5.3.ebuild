# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://repo.dec05eba.com/gpu-screen-recorder"
else
	SRC_URI="https://dec05eba.com/snapshot/${PN}.git.${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A screen recorder that has minimal impact on system performance"
HOMEPAGE="https://git.dec05eba.com/gpu-screen-recorder/about"
LICENSE="GPL-3"
SLOT="0"
IUSE="+filecaps systemd"

DEPEND="
	media-video/ffmpeg
	media-libs/libglvnd
	x11-libs/libXcomposite
	x11-libs/libXrandr
	x11-libs/libXfixes
	media-libs/libpulse
	media-libs/libva
	x11-libs/libdrm
	sys-libs/libcap
	dev-libs/wayland
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use systemd)
		$(meson_use filecaps capabilities)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
}
