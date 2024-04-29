# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit gnome2-utils meson python-single-r1

DESCRIPTION="Python GTK application to view and clean metadata in files, using mat2."
HOMEPAGE="https://metadatacleaner.romainvigier.fr https://gitlab.com/rmnvgr/metadata-cleaner"
SRC_URI="https://gitlab.com/rmnvgr/metadata-cleaner/-/archive/v${PV}/metadata-cleaner-v${PV}.tar.bz2"
S=${WORKDIR}/metadata-cleaner-v${PV}

LICENSE="GPL-3+ CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-util/itstool
	gui-libs/gtk:4
	gui-libs/libadwaita
	$(python_gen_cond_dep '
		app-misc/mat2[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
