# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="CrystalDiskInfo alternative for Linux"
HOMEPAGE="https://github.com/edisionnano/QDiskInfo"
SRC_URI="
	https://github.com/edisionnano/QDiskInfo/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/QDiskInfo-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,widgets]
"
RDEPEND="${DEPEND}
	sys-apps/smartmontools
"
