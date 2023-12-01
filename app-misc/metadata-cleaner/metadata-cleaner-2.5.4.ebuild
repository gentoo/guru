# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )

inherit gnome2-utils meson python-single-r1

DESCRIPTION="Python GTK application to view and clean metadata in files, using mat2."
HOMEPAGE="https://metadatacleaner.romainvigier.fr https://gitlab.com/rmnvgr/metadata-cleaner"
SRC_URI="https://gitlab.com/rmnvgr/metadata-cleaner/-/archive/v${PV}/metadata-cleaner-v${PV}.tar.bz2"

LICENSE="GPL-3+ CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-util/itstool
	gui-libs/gtk:4
	gui-libs/libadwaita
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
		app-misc/mat2[${PYTHON_USEDEP}]
	')
"

RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S=${WORKDIR}/metadata-cleaner-v${PV}

src_configure() {
	python_setup
	meson_src_configure
}

src_install() {
	meson_src_install
	python_optimize
}

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
