# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_BUILD_TYPE="Release"
WX_GTK_VER="3.2-gtk3"

inherit cmake wxwidgets xdg

MY_PN="wxFormBuilder"
DESCRIPTION="A wxWidgets GUI Builder"
HOMEPAGE="https://github.com/wxFormBuilder/wxFormBuilder"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
RESTRICT="mirror"

RDEPEND="
	dev-libs/tinyxml2
	x11-libs/wxGTK:${WX_GTK_VER}[X,gstreamer]
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.71
"

PATCHES=( "${FILESDIR}/${P}-fix-build.patch" )
