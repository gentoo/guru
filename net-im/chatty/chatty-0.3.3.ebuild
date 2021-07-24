# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg

COMMIT="501805ee4e013470c1c9eb17e930f9fe914e3671"

DESCRIPTION="Messaging client"
HOMEPAGE="https://source.puri.sm/Librem5/chatty"
SRC_URI="https://source.puri.sm/Librem5/chatty/-/archive//${COMMIT}.tar.gz -> ${P}.tar.gz"


LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~arm64 ~arm ~x86"

DEPEND="gnome-extra/evolution-data-server[phonenumber]
		dev-libs/feedbackd
		gui-libs/libhandy
		x11-plugins/purple-mm-sms
		dev-libs/olm
		dev-libs/libphonenumber
		x11-libs/gtk+:3
		net-im/jabber-base
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
