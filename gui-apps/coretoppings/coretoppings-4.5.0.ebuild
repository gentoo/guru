# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="Additional features, plugins, widgets etc for C Suite"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/coretoppings"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/coreapps/coretoppings.git"
else
	SRC_URI="https://gitlab.com/cubocore/coreapps/coretoppings/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="location pulseaudio"

DEPEND="
	dev-libs/libdbusmenu-qt
	dev-qt/qtbluetooth:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	gui-libs/libcprime
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXrender
"
RDEPEND="
	${DEPEND}
	location? ( dev-qt/qtlocation:5	)
	pulseaudio? ( media-libs/libpulse )
"
