# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop gnome2-utils meson pam readme.gentoo-r1 vala systemd xdg

MY_P="${PN}-v${PV}"
MY_COMMIT="c5ab6037f460406ac9799b1e5765de3ce0097a8b"

DESCRIPTION="A pure Wayland shell prototype for GNOME on mobile devices"
HOMEPAGE="https://source.puri.sm/Librem5/phosh"
SRC_URI="
	https://source.puri.sm/Librem5/phosh/-/archive/v${PV}/${MY_P}.tar.gz
	https://gitlab.gnome.org/GNOME/libgnome-volume-control/-/archive/${MY_COMMIT}.tar.gz -> libgnome-volume-control-${MY_COMMIT}.tar.gz
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
	gnome-base/gnome-desktop
	gnome-base/gnome-session
	x11-themes/gnome-backgrounds
	x11-wm/phoc
	systemd? ( sys-apps/systemd )
	sys-power/upower
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/ctags
	dev-util/meson
"

src_prepare() {
	default
	eapply_user
	rm -r "${S}"/subprojects/gvc || die
	mv "${WORKDIR}"/libgnome-volume-control-"${MY_COMMIT}" "${S}"/subprojects/gvc || die
}

src_install() {
	default
	meson_src_install
	newpamd "${FILESDIR}"/pam_phosh 'phosh'
	systemd_newunit "${FILESDIR}"/phosh.service 'phosh.service'
	domenu "${FILESDIR}"/sm.puri.OSK0.desktop

	DOC_CONTENTS="
	To amend the existing password policy please see the man 5 passwdqc.conf
	page and then edit the /etc/security/passwdqc.conf file to change enforce=none
	to allow use digit only password as phosh only support passcode for now
	"
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
