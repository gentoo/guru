# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="An unofficial WhatsApp desktop application for Linux"
HOMEPAGE="https://github.com/eneshecan/whatsapp-for-linux"
SRC_URI="https://github.com/eneshecan/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-cpp/atkmm
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:3.0
	dev-libs/glib:2
	dev-libs/libappindicator:3
	dev-libs/libsigc++:2
	net-libs/webkit-gtk:4=
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"
