# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A Qt5-based IM client for the Matrix protocol"
HOMEPAGE="https://github.com/QMatrixClient/Quaternion https://matrix.org/docs/projects/client/quaternion.html"
SRC_URI="https://github.com/QMatrixClient/Quaternion/archive/${PV}.tar.gz -> ${P}.tar.gz"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE="+keychain"

DEPEND="
	dev-qt/qtwidgets:5=
	dev-qt/qtnetwork:5=
	dev-qt/qtquickcontrols:5=
	dev-qt/qtquickcontrols2:5=
	dev-qt/qtscript:5=
	dev-qt/qtgui:5=
	dev-qt/linguist-tools:5=
	dev-qt/qtmultimedia:5=
	>=net-libs/libqmatrixclient-0.5.1:=
	keychain? ( dev-libs/qtkeychain:= )
"

src_prepare() {
	# I wouldn't be surprised that Qt on a Ubuntu PPA is broken
	# https://github.com/quotient-im/Quaternion/pull/484/files#r256167611
	sed -i 's/Multimedia DBus)/Multimedia)/' CMakeLists.txt || die "Failed removing hard-dep on QtDbus"

	default
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_KEYCHAIN=$(usex keychain)
	)

	cmake_src_configure
}
