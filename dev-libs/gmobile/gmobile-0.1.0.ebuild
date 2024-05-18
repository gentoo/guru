# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
VALA_USE_DEPEND="vapigen"

inherit meson verify-sig

DESCRIPTION="Mobile related helpers for glib based projects"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/gmobile/"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="gtk-doc +introspection test"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-libs/glib-2.66:2
	>=dev-libs/json-glib-1.6.2
	introspection? ( dev-libs/gobject-introspection )
"
RDEPEND="${DEPEND}"
BDEPEND="
	gtk-doc? ( >=dev-util/gi-docgen-2021.1 )
	verify-sig? ( sec-keys/openpgp-keys-phosh )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"

src_configure() {
	local emesonargs=(
		-Dexamples=false
		$(meson_use gtk-doc gtk_doc)
		$(meson_use introspection)
		$(meson_use test tests)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	# https://bugs.gentoo.org/930407
	find "${ED}"/usr/$(get_libdir) -name "*.a" -delete || die

	if use gtk-doc; then
		local gtkdocdir="${ED}/usr/share/gtk-doc/html/"
		mkdir -p "${gtkdocdir}" || die
		mv "${ED}"/usr/share/doc/${PN}-${SLOT} "${gtkdocdir}" || die
	fi
}
