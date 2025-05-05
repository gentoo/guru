# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="An activity viewer for C Suite"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/corestuff"
SRC_URI="https://gitlab.com/cubocore/coreapps/corestuff/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[concurrent,dbus,gui,network,widgets]
	>=gui-libs/libcprime-5.0.0
	>=gui-libs/libcsys-5.0.0
	kde-frameworks/kglobalaccel:6
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libxcb:=
	x11-libs/libXi
	x11-libs/xcb-util-wm
"
RDEPEND="${DEPEND}"
