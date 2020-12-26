# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit gnome2-utils meson xdg python-any-r1

DESCRIPTION="A password manager for GNOME"
HOMEPAGE="https://gitlab.gnome.org/World/PasswordSafe"
SRC_URI="https://gitlab.gnome.org/World/PasswordSafe/-/archive/${PV}/PasswordSafe-${PV}.tar.bz2"

LICENSE="GPL-2+"
IUSE="debug +introspection"
KEYWORDS="~amd64 ~x86"
SLOT="0"

S="${WORKDIR}/PasswordSafe-${PV}"

DEPEND="
	$(python_gen_any_dep '
		dev-python/pycryptodome[${PYTHON_USEDEP}]
		>=dev-python/pykeepass-3.2.0[${PYTHON_USEDEP}]
	')
	gui-libs/libhandy:1=[introspection?]
	>=dev-libs/libpwquality-1.4.0[python]
	>=x11-libs/gtk+-3.24.1:3[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.6.7:= )
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		-Dprofile=$(usex debug development default)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_optimize
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_pkg_postrm
}
