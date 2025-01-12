# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Qt6 Qml style provider for hypr* apps"
HOMEPAGE="https://wiki.hyprland.org/Hypr-Ecosystem/hyprland-qt-support"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/hyprlang-0.6.0
	dev-qt/qtbase:6
	dev-qt/qtdeclarative:6
"

RDEPEND="
	${DEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DINSTALL_QML_PREFIX="${EPFREIX}/$(get_libdir)/qt6/qml"
	)

	cmake_src_configure
}
