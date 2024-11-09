# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Polkit authentication agent for Hyprland, written in Qt/QML"
HOMEPAGE="https://wiki.hyprland.org/Hypr-Ecosystem/hyprpolkitagent"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6
	gui-libs/hyprutils
	sys-auth/polkit
	sys-auth/polkit-qt[qt6]
"

RDEPEND="
	${DEPEND}
"

BDEPEND="
	virtual/pkgconfig
"
