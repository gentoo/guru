# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
COMMIT="cc0abf87c37920540f2439a556e6a480c28f8f46"

inherit meson

DESCRIPTION="A Wayland Native VNC Client"
HOMEPAGE="https://github.com/any1/wlvncc"
SRC_URI="https://github.com/any1/wlvncc/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="video_cards_nvidia"

DEPEND="
	dev-libs/lzo
	dev-libs/wayland-protocols
	x11-libs/libdrm
"
RDEPEND="
	dev-libs/aml
	x11-libs/libxkbcommon
	x11-libs/pixman
	dev-libs/wayland
	video_cards_nvidia? ( gui-libs/egl-gbm )
	!video_cards_nvidia? ( media-libs/mesa )
"
