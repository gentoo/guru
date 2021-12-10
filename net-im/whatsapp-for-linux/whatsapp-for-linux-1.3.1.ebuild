# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="An unofficial WhatsApp desktop application for Linux"
HOMEPAGE="https://github.com/eneshecan/whatsapp-for-linux"
SRC_URI="https://github.com/eneshecan/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-cpp/gtkmm:3.0
		net-libs/webkit-gtk
		dev-libs/libappindicator:3"

DEPEND="${RDEPEND}"

src_prepare() {
	cmake_src_prepare
}
