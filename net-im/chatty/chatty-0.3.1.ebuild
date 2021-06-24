# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson xdg

MY_P="${PN}-v${PV}"

DESCRIPTION="Messaging client"
HOMEPAGE="https://source.puri.sm/Librem5/chatty"
SRC_URI="https://source.puri.sm/Librem5/chatty/-/archive/v0.3.1/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

S="${WORKDIR}/${MY_P}"

DEPEND="
	dev-libs/libphonenumber
	dev-libs/feedbackd
	>=gui-libs/libhandy-1.1.90
	dev-libs/olm
	net-im/jabber-base
	x11-libs/gtk+:3
	x11-plugins/purple-mm-sms
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
