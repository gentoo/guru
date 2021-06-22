# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vala meson gnome2-utils xdg

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"
# 0.13.0 does not work atm
WL_PV="0.12.0"
WL_P="wlroots-${WL_PV}"

DESCRIPTION="Wlroots based Phone compositor"
HOMEPAGE="https://source.puri.sm/Librem5/phoc"

# we don't use the version on gentoo because it breaks
# the phoc installation. we follow method used in archlinuxarm
SRC_URI="
	https://source.puri.sm/Librem5/phoc/-/archive/${MY_PV}/${MY_P}.tar.gz
	https://github.com/swaywm/wlroots/releases/download/${WL_PV}/${WL_P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+introspection"

DEPEND="
	dev-libs/glib
	dev-libs/gobject-introspection
	dev-libs/libinput
	gnome-base/gnome-desktop
	!gui-libs/wlroots
	x11-libs/xcb-util
	x11-libs/xcb-util-wm
	x11-wm/mutter
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/ctags
	dev-util/meson
	virtual/pkgconfig
	x11-base/xorg-server
"

PATCHES=(
	"${FILESDIR}/0001-seat-Don-t-notify-on-key-release.patch"
	"${FILESDIR}/0002-seat-inhibit-touch-events-when-in-power-save-mode-or.patch"
)

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	eapply_user
	rm -r "${S}"/subprojects/wlroots || die
	mv "${WORKDIR}/${WL_P}" "${S}"/subprojects/wlroots || die
}

src_configure() {
	local emesonargs=(
		-Ddefault_library=shared
		-Dtests=false
		-Dwlroots:logind-provider=systemd
		-Dwlroots:libseat=disabled
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	dobin "${S}"/helpers/scale-to-fit
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
