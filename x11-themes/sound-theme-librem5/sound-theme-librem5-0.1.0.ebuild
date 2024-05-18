# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Sound theme for the Librem 5/PinePhone"
HOMEPAGE="https://source.puri.sm/Librem5/sound-theme-librem5"
SRC_URI="https://source.puri.sm/Librem5/sound-theme-librem5/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-2 LGPL-2 CC-BY-3.0 CC-BY-SA-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	sys-devel/gettext
	dev-libs/glib:2
	>=dev-util/intltool-0.40
"

src_install() {
	insinto /usr/share/sounds/
	doins -r librem5
}
