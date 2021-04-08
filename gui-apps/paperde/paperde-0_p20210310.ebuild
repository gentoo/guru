# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

DESCRIPTION="Simple, sleek QT based DE for wayland using wayfire"

HOMEPAGE="https://gitlab.com/cubocore/paper/paperde"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/paper/${PN}"
else
	COMMIT=65c755306688203ddc32bbc099ba1de03166cde9
	SRC_URI="https://gitlab.com/cubocore/paper/${PN}/-/archive/${COMMIT}/paperde-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/libdbusmenu-qt
	dev-libs/wayland
	dev-qt/designer:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5[X]
	dev-qt/qtsvg:5
	gui-libs/libcprime
	gui-libs/libcsys
"
RDEPEND="${DEPEND}
	gui-wm/wayfire[X]
	x11-misc/qt5ct
"

src_prepare() {
	cmake_src_prepare
	xdg_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DPKGSHAREDPATH="${EPREFIX}/usr/share/paperde"
		-DPKGCONFPATH="${EPREFIX}/etc/xdg/paperde"
	)
	cmake_src_configure
}
