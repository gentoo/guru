# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop gnome2-utils meson pam readme.gentoo-r1 systemd xdg

MY_P="phosh-v${PV}"
LVC_COMMIT="ae1a34aafce7026b8c0f65a43c9192d756fe1057"
LCU_COMMIT="acfbb136bbf74514e0b9801ce6c1e8acf36350b6"

DESCRIPTION="A pure Wayland shell prototype for GNOME on mobile devices"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/phosh/"
SRC_URI="
	https://gitlab.gnome.org/World/Phosh/phosh/-/archive/v${PV}/${MY_P}.tar.gz
	https://gitlab.gnome.org/GNOME/libgnome-volume-control/-/archive/${LVC_COMMIT}/libgnome-volume-control-${LVC_COMMIT}.tar.gz
	https://gitlab.gnome.org/World/Phosh/libcall-ui/-/archive/${LCU_COMMIT}/libcall-ui-${LCU_COMMIT}.tar.gz
"
S="${WORKDIR}/${MY_P}"

KEYWORDS="~amd64 ~arm64"
LICENSE="GPL-3"
SLOT="0"
IUSE="+systemd"

DEPEND="
	app-crypt/gcr
	dev-libs/feedbackd
	media-sound/pulseaudio
	>=gui-libs/libhandy-1.1.90
	net-misc/networkmanager
	gnome-base/gnome-control-center
	gnome-base/gnome-desktop
	gnome-base/gnome-session
	x11-themes/gnome-backgrounds
	gnome-base/gnome-keyring
	gnome-base/gnome-shell
	gui-wm/phoc
	systemd? ( sys-apps/systemd )
	sys-power/upower
	app-misc/geoclue
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/ctags
	dev-build/meson
"

src_prepare() {
	default
	rm -r "${S}"/subprojects/gvc || die
	mv "${WORKDIR}"/libgnome-volume-control-"${LVC_COMMIT}" "${S}"/subprojects/gvc || die
	rm -r "${S}"/subprojects/libcall-ui || die
	mv "${WORKDIR}"/libcall-ui-"${LCU_COMMIT}" "${S}"/subprojects/libcall-ui || die
}

src_install() {
	default
	meson_src_install
	newpamd "${FILESDIR}"/pam_phosh 'phosh'
	systemd_newunit "${FILESDIR}"/phosh.service 'phosh.service'
	domenu "${FILESDIR}"/sm.puri.OSK0.desktop

	DOC_CONTENTS="To amend the existing password policy please see the man 5 passwdqc.conf
				page and then edit the /etc/security/passwdqc.conf file to change enforce=none
				to allow use digit only password as phosh only support passcode for now"
	readme.gentoo_create_doc
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	readme.gentoo_print_elog
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
