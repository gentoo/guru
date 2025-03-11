# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature

DESCRIPTION="Library for managing the device"
HOMEPAGE="https://gitlab.com/cubocore/libcsys"
SRC_URI="https://gitlab.com/cubocore/libcsys/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[dbus,network]
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	optfeature "storage management support" sys-fs/udisks:2
}
