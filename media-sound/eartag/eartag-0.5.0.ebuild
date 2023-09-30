# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="GTK4 MusicBrainz audio tagger"
HOMEPAGE="https://gitlab.gnome.org/World/eartag"
SRC_URI="https://gitlab.gnome.org/World/eartag/-/archive/${PV}/eartag-${PV}.tar.bz2"
S="${WORKDIR}/eartag-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
		${PYTHON_DEPS}
		>=gui-libs/gtk-4.12.0
		>=gui-libs/libadwaita-1.4.0
		>=dev-python/pygobject-3.44.1
		>=dev-python/pillow-10.0.0
		>=media-libs/mutagen-1.46.0
		>=dev-python/python-magic-0.4.27
		>=dev-python/pyacoustid-1.2.2-r1
"
RDEPEND="${DEPEND}"
BDEPEND="
		>=dev-util/meson-1.2.1-r1
"

src_install() {
	sed -i \
		-e 's/^#!.*/#!\/usr\/bin\/python3/g' \
		"${S}-build/src/eartag" \
	    || die

	meson_src_install
	python_optimize
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
