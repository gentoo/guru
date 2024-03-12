# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Gromit-MPX is a multi-pointer GTK3 port of the Gromit desktop annotation tool"
HOMEPAGE="https://github.com/bk138/gromit-mpx"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bk138/${PN}.git"
else
	SRC_URI="https://github.com/bk138/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
LICENSE="GPL-2"

RDEPEND="
	x11-libs/gtk+:3
	dev-libs/libappindicator:3
	x11-libs/libX11
	>=x11-apps/xinput-1.3
"
DEPEND="${RDEPEND}"

src_prepare () {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}"/etc
	)

	cmake_src_configure
}
