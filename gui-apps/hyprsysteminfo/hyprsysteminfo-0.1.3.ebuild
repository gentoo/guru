# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hyprland's system information GUI application"
HOMEPAGE="https://wiki.hyprland.org/Hypr-Ecosystem/hyprsysteminfo"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6
	dev-qt/qtwayland:6
	gui-libs/hyprutils:=
"

RDEPEND="
	${DEPEND}
	gui-libs/hyprland-qt-support
"

BDEPEND="
	virtual/pkgconfig
"
