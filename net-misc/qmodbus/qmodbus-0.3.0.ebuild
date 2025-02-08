# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="QT Modbus Master"
HOMEPAGE="https://github.com/ed-chemnitz/qmodbus"
SRC_URI="https://github.com/ed-chemnitz/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	eqmake5
}

src_install() {
	insinto /usr/bin
	dobin qmodbus
}
