# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="KWin plugin for binding keyboard, mouse, touchpad and touchscreen actions"
HOMEPAGE="https://github.com/InputActions/kwin"
SRC_URI="https://github.com/InputActions/kwin/releases/download/v${PV}/source.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

# kwin
RDEPEND="
	app-laptop/inputactions-ctl
	dev-qt/qtbase:6[widgets]
	kde-plasma/kwin
	x11-libs/libxkbcommon
"
# core
RDEPEND+="
	dev-cpp/yaml-cpp
	dev-libs/libevdev
	dev-qt/qtbase:6[dbus]
"
BDEPEND="
	kde-frameworks/extra-cmake-modules
"
