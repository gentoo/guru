# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Scripts/commands used in the Qtilities organization "
HOMEPAGE="https://qtilities.github.io/"
SRC_URI="https://github.com/qtilities/${PN}/archive/refs/tags/${PV}.tar.gz"
S="${WORKDIR}/${PN}-0.1.2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=/usr"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
