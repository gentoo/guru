# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Qt plugin for HEIF images"
HOMEPAGE="https://github.com/jakar/qt-heif-image-plugin"
SRC_URI="https://github.com/jakar/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-qt/qtcore
	dev-qt/qtgui
	media-libs/libheif:0/1.6
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
