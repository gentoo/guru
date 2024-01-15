# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="Free open-source non-linear video editor"
HOMEPAGE="https://olivevideoeditor.org https://github.com/olive-editor/olive"

LICENSE="GPL-3"
SLOT="0"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/olive-editor/olive.git"
else
	COMMIT="af76fbf0e189b73663fe2b5d20007fe7c69b6081"
	VERSION_REV="af76fbf"
	SRC_URI="https://github.com/olive-editor/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

IDEPEND="dev-util/desktop-file-utils"
RDEPEND="
	>=dev-qt/linguist-tools-5.0.0
	>=dev-qt/qtconcurrent-5.0.0
	>=dev-qt/qtdbus-5.0.0
	>=dev-qt/qtnetwork-5.0.0
	>=dev-qt/qtopengl-5.0.0
	>=dev-qt/qtcore-5.0.0
	>=media-libs/opencolorio-2.1.1
	>=media-libs/openimageio-2.1.12
	>=media-video/ffmpeg-3.0.0
	media-libs/openexr
	media-libs/portaudio
	virtual/opengl"
DEPEND="${RDEPEND}"
DOCS=( README.md )

src_prepare() {
	cmake_src_prepare
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
