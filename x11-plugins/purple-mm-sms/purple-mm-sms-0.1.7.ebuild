# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Purple SMS plugin using ModemManager"
HOMEPAGE="https://source.puri.sm/Librem5/purple-mm-sms"
SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	net-misc/modemmanager
	net-im/pidgin
"

RDEPEND="${DEPEND}"
