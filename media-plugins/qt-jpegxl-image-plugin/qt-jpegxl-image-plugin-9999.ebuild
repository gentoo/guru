# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit git-r3 cmake

DESCRIPTION="Qt plug-in to allow Qt and KDE based applications to read/write JXL images."
HOMEPAGE="https://github.com/novomesk/qt-jpegxl-image-plugin"

EGIT_REPO_URI="https://github.com/novomesk/qt-jpegxl-image-plugin.git"

KEYWORDS=""
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=">=dev-qt/qtgui-5.14.0:5
	media-libs/libjxl
"

BDEPEND=">=kde-frameworks/extra-cmake-modules-5.70:5"

RDEPEND="${DEPEND}"
