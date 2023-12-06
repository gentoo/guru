# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
VALA_MIN_API_VERSION="0.44"
inherit vala xdg

DESCRIPTION="An easy to use manager and mounter for encfs stashes"
HOMEPAGE="https://launchpad.net/gencfsm"
SRC_URI="https://launchpad.net/gencfsm/trunk/${PV}/+download/${PN}_${PV}.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+appindicator"

DEPEND="
	gnome-base/dconf
	sys-fs/encfs
	sys-fs/fuse
	app-crypt/libsecret
	x11-libs/libICE
	dev-libs/glib:2
	dev-libs/libappindicator:3
	dev-libs/libgee:0.8=
	x11-libs/gtk+:3
	x11-libs/libSM
"
RDEPEND="${DEPEND}"
BDEPEND="
	$(vala_depend)
	sys-devel/libtool
	>=sys-devel/automake-1.11
	appindicator? ( dev-libs/libappindicator )
	x11-libs/gtk+:3
	>=dev-libs/glib-2
	gnome-base/gnome-keyring
	dev-libs/libgee
	dev-util/intltool
	x11-libs/libSM
"

PATCHES=( "${FILESDIR}/${P}-fix-implicit-function-decl.patch" )

src_prepare() {
	vala_setup
	default
}

src_configure() {
	local conf
	./autogen.sh
	if ! use appindicator; then
		conf+=" --disable-appindicator"
	fi
	econf  ${conf}
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
