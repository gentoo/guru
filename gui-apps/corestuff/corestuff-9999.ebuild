# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="An activity viewer for C Suite"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/corestuff"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/coreapps/corestuff.git"
else
	SRC_URI="https://gitlab.com/cubocore/coreapps/corestuff/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	gui-libs/libcprime
	gui-libs/libcsys
	kde-frameworks/kglobalaccel:5
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libxcb:=
	x11-libs/libXi
	x11-libs/xcb-util-wm
"
RDEPEND="${DEPEND}"
