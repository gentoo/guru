# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/xytovl/asus-numpad.git"
	inherit git-r3
else
	SRC_URI="https://github.com/xytovl/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit linux-info meson

DESCRIPTION="User-space driver for Asus numpad"
HOMEPAGE="https://github.com/xytovl/asus-numpad"

LICENSE="GPL-3"
SLOT="0"

DEPEND=">=dev-libs/libevdev-1.12.0"
RDEPEND=${DEPEND}

src_configure() {
	meson_src_configure
}

src_install() {
	meson_src_install
}
