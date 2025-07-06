# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson pam systemd toolchain-funcs vala verify-sig virtualx xdg

MY_PN="${PN%-shell}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Pure Wayland shell for mobile devices"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/phosh/"
SRC_URI="https://sources.phosh.mobi/releases/${MY_PN}/${MY_P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${MY_PN}/${MY_P}.tar.xz.asc )"
S="${WORKDIR}/${MY_P}"

LICENSE="CC0-1.0 CC-BY-SA-4.0 GPL-2+ GPL-3+ LGPL-2+ LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="gtk-doc introspection +lockscreen-plugins man +plugins systemd test test-full vala"
REQUIRED_USE="
	gtk-doc? ( introspection )
	lockscreen-plugins? ( plugins )
	test? ( plugins lockscreen-plugins )
	vala? ( introspection )
"

COMMON_DEPEND="
	>=app-crypt/gcr-3.7.5:0=[introspection?]
	app-crypt/libsecret
	>=dev-libs/appstream-1.0.0:=
	>=dev-libs/feedbackd-0.7.0
	dev-libs/fribidi
	>=dev-libs/glib-2.76:2
	dev-libs/gmobile
	dev-libs/libgudev:=
	dev-libs/libical:=
	>=dev-libs/wayland-1.14
	>=gnome-base/gnome-desktop-3.26:3=[introspection?]
	>=gnome-base/gsettings-desktop-schemas-47
	>=gnome-extra/evolution-data-server-3.33.1:=
	>=gui-libs/libhandy-1.1.90:1[introspection?]
	media-libs/libpulse[glib]
	media-sound/callaudiod
	>=net-libs/libsoup-3.6:3.0
	net-misc/modemmanager:=
	>=net-misc/networkmanager-1.14[introspection?]
	>=net-wireless/gnome-bluetooth-46.0:3=[introspection?]
	sys-apps/dbus
	>=sys-auth/polkit-0.122
	sys-libs/pam
	>=sys-power/upower-0.99.1:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	>=x11-libs/gtk+-3.22:3[introspection?,wayland]
	systemd? ( >=sys-apps/systemd-241:= )
	!systemd? ( >=sys-auth/elogind-241 )
	plugins? (
		>=gui-libs/gtk-4.12:4
		>=gui-libs/libadwaita-1.5:1
		lockscreen-plugins? (
			app-text/evince:=
		)
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
	vala? (
		$(vala_depend)
		>=net-misc/networkmanager-1.14[vala]
	)
"
RDEPEND="
	${COMMON_DEPEND:?}
	${RUNTIME_DEPEND:?}
	systemd? ( sys-libs/libcap )
"
BDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/wayland-scanner
	sys-devel/gettext
	virtual/pkgconfig
	gtk-doc? ( dev-util/gi-docgen )
	introspection? ( dev-libs/gobject-introspection )
	man? ( dev-python/docutils )
	test-full? ( >=gui-wm/phoc-0.45.0 )
	verify-sig? ( sec-keys/openpgp-keys-phosh )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"

# https://gitlab.gnome.org/World/Phosh/phosh/-/issues/1240
# https://gitlab.gnome.org/World/Phosh/phosh/-/merge_requests/1733
RESTRICT="test"

src_prepare() {
	use vala && vala_setup
	default
}

src_configure() {
	local emesonargs=(
		-Dcompositor="${EPREFIX}"/usr/bin/phoc
		-Dtools=true
		$(meson_use gtk-doc gtk_doc)
		$(meson_use introspection)
		$(meson_use introspection bindings-lib)
		$(meson_use lockscreen-plugins)
		$(meson_use plugins quick-setting-plugins)
		$(meson_use man)
		$(meson_use test tests)
		$(meson_feature test-full phoc_tests)
		$(meson_use vala vapi)
	)
	meson_src_configure
}

src_test() {
	my_src_test() {
		local -x LC_ALL="C.UTF-8"
		local -x WLR_RENDERER="pixman"
		local -x PHOSH_TEST_PHOC_INI="${T}/phoc.ini"

		meson_src_test --suite unit || return 1
		if use test-full; then
			meson_src_test --suite integration --timeout-multiplier 2 || return 1
		fi
	}

	# Xwayland breaks "phosh:integration / shell", pollutes /tmp
	cat data/phoc.ini - > "${T}"/phoc.ini <<- EOF || die
		[core]
		xwayland=false
	EOF

	virtx my_src_test
}

src_install() {
	meson_src_install
	find "${ED}/usr/$(get_libdir)" -name '*.a' -delete || die

	pamd_mimic system-local-login phosh auth account session
	systemd_douserunit data/phosh.service

	if use gtk-doc; then
		mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
		mv "${ED}"/usr/share/doc/${MY_PN}-${SLOT} "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}

phosh_giomodule_cache_update() {
	local plugins_dir
	plugins_dir=$("$(tc-getPKG_CONFIG)" --variable=lockscreen_plugins_dir phosh-plugins) || return 1

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
