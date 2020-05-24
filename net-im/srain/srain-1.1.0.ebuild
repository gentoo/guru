# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils xdg-utils

DESCRIPTION="Modern, beautiful IRC client written in GTK+ 3"
HOMEPAGE="https://github.com/SrainApp/srain"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/SrainApp/${PN}.git"
	KEYWORDS=""
else
	MY_PV="${PV/_rc/rc}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="https://github.com/SrainApp/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="debug"

DEPEND="
	dev-libs/libconfig
	net-libs/libsoup
"
RDEPEND="${DEPEND}
	>=x11-libs/gtk+-3.22.0
	x11-libs/libnotify
"

src_configure(){
	econf $(use_enable debug)
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
