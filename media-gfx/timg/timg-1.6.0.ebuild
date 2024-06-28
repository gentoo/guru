# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cmake

DESCRIPTION="Terminal image and video viewer"

HOMEPAGE="https://timg.sh/"

SRC_URI="https://github.com/hzeller/timg/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-arch/libdeflate-1.19
	>=dev-util/pkgconf-2.2.0
	>=dev-vcs/git-2.44.2
	>=media-libs/libsixel-1.10.3-r1
	>=media-libs/libjpeg-turbo-3.0.0
	>=media-libs/libexif-0.6.24
	>=media-video/ffmpeg-4.4.4-r9
	>=media-gfx/graphicsmagick-1.3.42
	>=gnome-base/librsvg-2.57.3
	>=x11-libs/cairo-1.18.0
	>=app-text/poppler-24.04.0[cairo]
"

DEPEND="${RDEPEND}"
