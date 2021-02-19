# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="dwm for Wayland"
HOMEPAGE="https://github.com/djpohly/dwl"
SRC_URI="https://github.com/djpohly/dwl/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="gui-libs/wlroots
dev-libs/wayland-protocols"
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX="${D}"/usr install
}
