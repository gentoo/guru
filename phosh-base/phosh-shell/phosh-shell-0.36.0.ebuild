# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson pam systemd verify-sig virtualx xdg

MY_PN="${PN%-shell}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Pure Wayland shell for mobile devices"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/phosh/"
SRC_URI="https://sources.phosh.mobi/releases/${MY_PN}/${MY_P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${MY_PN}/${MY_P}.tar.xz.asc )"
S="${WORKDIR}/${MY_P}"

KEYWORDS="~amd64 ~arm64"
LICENSE="CC0-1.0 CC-BY-SA-4.0 GPL-2+ GPL-3+ LGPL-2+ LGPL-2.1+ MIT"
SLOT="0"
IUSE="elogind gtk-doc +lockscreen-plugins man test test-full"
REQUIRED_USE="test? ( lockscreen-plugins )"

COMMON_DEPEND="
	>=app-crypt/gcr-3.7.5:0
	app-crypt/libsecret
	>=dev-libs/feedbackd-0.2.0
	dev-libs/fribidi
	>=dev-libs/glib-2.76:2
	>=dev-libs/json-glib-1.6.2
	dev-libs/libgudev:=
	>=dev-libs/wayland-1.14
	>=gnome-base/gnome-desktop-3.26:3
	>=gnome-base/gsettings-desktop-schemas-42
	>=gnome-extra/evolution-data-server-3.33.1:=
	>=gui-libs/libhandy-1.1.90:1
	media-libs/libpulse[glib]
	media-sound/callaudiod
	>=net-misc/networkmanager-1.14
	sys-apps/dbus
	>=sys-auth/polkit-0.105
	sys-libs/pam
	>=sys-power/upower-0.99.1:=
	>=x11-libs/gtk+-3.22:3[wayland]
	elogind? ( >=sys-auth/elogind-241 )
	!elogind? ( >=sys-apps/systemd-241:= )
	lockscreen-plugins? (
		app-text/evince:=
		gui-libs/gtk:4
		gui-libs/libadwaita:1
	)
"
RUNTIME_DEPEND="
	gnome-base/gnome-shell
	virtual/freedesktop-icon-theme
	x11-themes/gnome-themes-standard
"

DEPEND="
	${COMMON_DEPEND:?}
	>=dev-libs/wayland-protocols-1.12
	test-full? ( ${RUNTIME_DEPEND:?} )
"
RDEPEND="
	${COMMON_DEPEND:?}
	${RUNTIME_DEPEND:?}
	!elogind? ( sys-libs/libcap )
"
BDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/wayland-scanner
	sys-devel/gettext
	gtk-doc? ( dev-util/gi-docgen )
	man? ( dev-python/docutils )
	test-full? ( >=gui-wm/phoc-0.36.0-r1 )
	verify-sig? ( sec-keys/openpgp-keys-phosh )
"

VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}/usr/share/openpgp-keys/phosh.asc"

src_configure() {
	local emesonargs=(
		-Dcompositor="${EPREFIX}"/usr/bin/phoc
		-Dsystemd=true
		-Dtools=true
		$(meson_use gtk-doc gtk_doc)
		$(meson_use lockscreen-plugins)
		$(meson_use man)
		$(meson_use test tests)
		$(meson_feature test-full phoc_tests)
	)
	meson_src_configure
}

src_test() {
	local -x LC_ALL="C.UTF-8"
	local -x WLR_RENDERER="pixman"

	virtx meson_src_test --suite unit
	if use test-full; then
		virtx meson_src_test --suite integration
	fi
}

src_install() {
	meson_src_install
	pamd_mimic system-local-login phosh auth account session
	systemd_douserunit data/phosh.service

	if use gtk-doc; then
		mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
		mv "${ED}"/usr/share/doc/${MY_PN}-${SLOT} "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}

phosh_giomodule_cache_update() {
	local plugins_dir
	plugins_dir=$(pkg-config --variable=lockscreen_plugins_dir phosh-plugins) || return 1

	ebegin "Updating GIO modules cache"
	gio-querymodules "${plugins_dir}"
	eend $?
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	phosh_giomodule_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
	phosh_giomodule_cache_update
}
