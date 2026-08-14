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
	>=app-arch/libdeflate-1.24
	>=app-text/poppler-25.09.1[cairo]
	>=dev-libs/glib-2.84.4
	>=dev-util/pkgconf-2.5.1
	>=dev-vcs/git-2.51.0
	>=gnome-base/librsvg-2.60.0
	>=media-libs/libexif-0.6.25
	>=media-libs/libjpeg-turbo-3.1.1
	>=media-libs/libsixel-1.10.5
	>=media-gfx/graphicsmagick-1.3.45-r2
	>=media-video/ffmpeg-7.1.2
	>=x11-libs/cairo-1.18.4-r1
"

DEPEND="${RDEPEND}"
