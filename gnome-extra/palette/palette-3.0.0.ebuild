# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit gnome2-utils meson python-any-r1 vala xdg

HIG_COMMIT="9433d4215159da08a1d6db4090c987d178173670"

DESCRIPTION="Colour Palette tool"
HOMEPAGE="https://gitlab.gnome.org/World/design/palette"
SRC_URI="
	https://gitlab.gnome.org/World/design/palette/-/archive/${PV}/palette-${PV}.tar.bz2
	https://gitlab.gnome.org/Teams/Design/HIG-app-icons/-/archive/${HIG_COMMIT}/HIG-app-icons-${HIG_COMMIT}.tar.bz2
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	${PYTHON_DEPS}

	dev-libs/appstream
	dev-util/desktop-file-utils
	dev-util/gtk-update-icon-cache
	sys-devel/gettext
"

src_prepare() {
	default
	vala_setup

	mv "${WORKDIR}/HIG-app-icons-${HIG_COMMIT}" -T "${S}/src/hig" || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
