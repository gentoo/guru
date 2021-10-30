# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala xdg gnome2-utils

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"
# 0.13.0 does not work atm
WL_PV="0.12.0"
WL_P="wlroots-${WL_PV}"

DESCRIPTION="Wlroots based Phone compositor"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/phoc"

# we don't use the version on gentoo because it breaks
# the phoc installation. we follow method used in archlinuxarm
SRC_URI="
	https://gitlab.gnome.org/World/Phosh/phoc/-/archive/${MY_PV}/${MY_P}.tar.gz
	https://github.com/swaywm/wlroots/releases/download/${WL_PV}/${WL_P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+introspection +systemd test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/glib
	dev-libs/gobject-introspection
	dev-libs/libinput
	dev-libs/wayland
	dev-libs/wayland-protocols
	gnome-base/gnome-desktop
	systemd? (
		!sys-apps/openrc
		sys-apps/systemd
	)
	x11-libs/libdrm
	x11-libs/pixman
	x11-libs/xcb-util
	x11-libs/xcb-util-wm
	x11-wm/mutter
	sys-auth/seatd
"

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
	rm -r "${S}"/subprojects/wlroots || die "Failed to remove bundled wlroots"
	cp -r "${WORKDIR}/${WL_P}" "${S}"/subprojects/wlroots || die "Failed to copy right version of wlroots"

	cd "${S}"/subprojects/wlroots
	eapply "${FILESDIR}"/xcursor-fix-false-positive-stringop-truncation.diff
	eapply "${FILESDIR}"/Revert-layer-shell-error-on-0-dimension-without-anchors.diff

}

src_configure() {
	local emesonargs=(
		-Ddefault_library=shared
		-Dtests=false
	)
	meson_src_configure
}

src_install() {
	DESTDIR="${D}" meson_src_install
	dobin "${S}"/helpers/scale-to-fit
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
}
