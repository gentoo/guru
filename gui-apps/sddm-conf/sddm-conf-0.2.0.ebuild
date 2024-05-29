# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SDDM configuration editor"
HOMEPAGE="https://qtilities.github.io/"
SRC_URI="https://github.com/qtilities/${PN}/archive/refs/tags/${PV}.tar.gz"
S="${WORKDIR}/${PN}-0.2.0"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase
	sys-auth/polkit
	x11-misc/sddm
"
DEPEND="${RDEPEND} "
BDEPEND="
	dev-build/cmake
	dev-qt/qttools
	dev-build/qtilitools
	dev-qt/linguist-tools
"

src_configure() {
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=/usr"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
