# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 )

inherit gnome2-utils meson python-single-r1

DESCRIPTION="An RSS/Atom feed reader for GNOME."
HOMEPAGE="https://gitlab.gnome.org/World/gfeeds"
SRC_URI="https://gitlab.gnome.org/World/gfeeds/-/archive/${PV}/${P}.tar.bz2"

# This fixes 1 syntax-related compilation error and syntax warnings (usage of $)
PATCHES="${FILESDIR}/${P}-blueprint-0.80-fix.patch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
    ${PYTHON_DEPS}
    $(python_gen_cond_dep '
        dev-python/beautifulsoup4[${PYTHON_USEDEP}]
        dev-python/html5lib[${PYTHON_USEDEP}]
        dev-python/humanize[${PYTHON_USEDEP}]
        dev-python/pillow[${PYTHON_USEDEP}]
        dev-python/pygments[${PYTHON_USEDEP}]
        dev-python/python-dateutil[${PYTHON_USEDEP}]
        dev-python/python-magic[${PYTHON_USEDEP}]
        dev-python/pytz[${PYTHON_USEDEP}]
        dev-python/readability-lxml[${PYTHON_USEDEP}]
        dev-python/requests[${PYTHON_USEDEP}]
    ')
    dev-util/blueprint-compiler
    gui-libs/gtk:4
    gui-libs/libadwaita
    net-libs/syndication-domination[python]
    net-libs/webkit-gtk:6
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-build/meson-0.58"

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
    python_fix_shebang "${D}"/usr/bin/gfeeds
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
