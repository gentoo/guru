# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit gnome2-utils meson python-single-r1  xdg

DESCRIPTION="Tweak various aspects of GNOME"
HOMEPAGE="https://gitlab.gnome.org/TheEvilSkeleton/Refine"
SRC_URI="https://gitlab.gnome.org/TheEvilSkeleton/Refine/-/archive/${PV}/Refine-${PV}.tar.bz2 -> ${P}.tar.bz2"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/blueprint-compiler
	dev-util/glib-utils
	virtual/pkgconfig
"
src_prepare() {
	default
	xdg_environment_reset
}

src_configure() {
	local emesonargs=()
	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
