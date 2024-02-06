# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson virtualx verify-sig xdg

DESCRIPTION="On-screen keyboard stub"
HOMEPAGE="https://gitlab.gnome.org/guidog/phosh-osk-stub"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="elogind gtk-doc man test"
RESTRICT="!test? ( test )"

# TODO: package govarnam
# TODO: hunspell is automagic
COMMON_DEPEND="
	app-shells/fzf
	app-text/hunspell:=
	>=dev-libs/glib-2.66:2
	dev-libs/feedbackd
	dev-libs/json-glib
	>=dev-libs/wayland-1.14
	>=gnome-base/gnome-desktop-3.26:3
	>=gui-libs/libhandy-1.1.90:1
	>=x11-libs/gtk+-3.22:3[wayland]
	x11-libs/libxkbcommon[wayland]
	elogind? ( >=sys-auth/elogind-241 )
	!elogind? ( >=sys-apps/systemd-241:= )
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/wayland-protocols-1.12
"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gsettings-desktop-schemas
"
BDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2:2
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/wayland-scanner
	sys-devel/gettext
	gtk-doc? ( dev-util/gi-docgen )
	man? ( dev-python/docutils )
	test? ( dev-libs/json-glib )
	verify-sig? ( sec-keys/openpgp-keys-phosh )
"

VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}/usr/share/openpgp-keys/phosh.asc"

QA_DESKTOP_FILE="usr/share/applications/sm.puri.Phosh.OskStub.desktop"

src_configure() {
	local emesonargs=(
		-Ddefault_osk=false
		$(meson_use gtk-doc gtk_doc)
		$(meson_use man)
		$(meson_use test tests)
	)

	meson_src_configure
}

src_test() {
	virtx meson_src_test
}

src_install() {
	meson_src_install

	if use gtk-doc; then
		mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
		mv "${ED}"/usr/share/doc/pos-${SLOT} "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
