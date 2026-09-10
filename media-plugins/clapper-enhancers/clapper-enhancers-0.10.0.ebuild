# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit gnome2-utils meson python-single-r1

DESCRIPTION="Plugins enhancing Clapper library capabilities"
HOMEPAGE="https://github.com/Rafostar/clapper-enhancers"
SRC_URI="https://github.com/Rafostar/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+control-hub +http +mpris +sqlite3 +youtube"
REQUIRED_USE="youtube? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	>=dev-libs/glib-2.76:2
	dev-libs/libpeas:2
	>=media-libs/gstreamer-1.20.0:1.0
	>=media-video/clapper-0.10.0
	control-hub? (
		net-libs/libsoup:3.0
		>=net-libs/libmicrodns-0.2.0:=
	)
	http? (
		>=dev-libs/json-glib-1.2.0
		net-libs/libsoup:3.0
	)
	sqlite3? ( dev-db/sqlite:3 )
"
RDEPEND="${DEPEND}
	youtube? (
		${PYTHON_DEPS}
		dev-libs/libpeas:2[python,${PYTHON_SINGLE_USEDEP}]
		media-video/clapper[introspection]
		$(python_gen_cond_dep '
			dev-python/pygobject:3[${PYTHON_USEDEP}]
			net-misc/yt-dlp[${PYTHON_USEDEP}]
		')
	)
"
BDEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	virtual/pkgconfig
	mpris? ( dev-util/gdbus-codegen )
"

src_configure() {
	local emesonargs=(
		--auto-features=enabled
		$(meson_feature control-hub)
		$(meson_feature http lbry)
		$(meson_feature http peertube)
		$(meson_feature mpris)
		$(meson_feature sqlite3 recall)
		$(meson_feature youtube yt-dlp)
	)

	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
