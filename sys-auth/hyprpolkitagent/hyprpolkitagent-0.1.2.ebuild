# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="Polkit authentication agent for Hyprland, written in Qt/QML"
HOMEPAGE="https://wiki.hyprland.org/Hypr-Ecosystem/hyprpolkitagent"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6
	gui-libs/hyprutils:=
	sys-auth/polkit
	sys-auth/polkit-qt[qt6]
"

RDEPEND="
	${DEPEND}
	gui-libs/hyprland-qt-support
"

BDEPEND="
	virtual/pkgconfig
"

pkg_setup() {
	[[ ${MERGE_TYPE} == binary ]] && return

	if tc-is-gcc && ver_test $(gcc-version) -lt 14 ; then
		eerror "Hyprpolkitagent requires >=sys-devel/gcc-14 to build"
		eerror "Please upgrade GCC: emerge -v1 sys-devel/gcc"
		die "GCC version is too old to compile Hyprland!"
	elif tc-is-clang && ver_test $(clang-version) -lt 18 ; then
		eerror "Hyprpolkitagent requires >=llvm-core/clang-18 to build"
		eerror "Please upgrade Clang: emerge -v1 llvm-core/clang"
		die "Clang version is too old to compile Hyprland!"
	fi
}
