# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson

DESCRIPTION="An RSS/Atom feed reader for GNOME."
HOMEPAGE="https://gitlab.gnome.org/World/gfeeds"
SRC_URI="https://gitlab.gnome.org/World/gfeeds/-/archive/${PV}/${P}.tar.bz2"

PATCHES="${FILESDIR}/${P}-blueprint-0.80-fix.patch"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug"

DEPEND="
	dev-lang/python:3.11
	gui-libs/gtk:4
	gui-libs/libadwaita
	dev-python/beautifulsoup4
	dev-python/html5lib
	dev-python/humanize
	dev-python/pygments
	dev-python/pillow
	dev-python/pytz
	dev-python/python-magic
	dev-python/readability-lxml
	dev-python/requests
	~net-libs/syndication-domination-9999[python]
	net-libs/webkit-gtk:6
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-util/meson-0.58"

src_configure() {
	local emesonargs=(
		--buildtype $(usex debug debug release)
		--prefix=/usr
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
