# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..15} )
inherit meson xdg python-single-r1

DESCRIPTION="A translation app for GNOME"
HOMEPAGE="https://github.com/dialect-app/dialect"
SRC_URI="
	https://github.com/dialect-app/dialect/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/dialect-app/po/archive/refs/tags/${PV}.tar.gz -> ${P}-po.tar.gz
"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE="${PYTHON_IUSE}"

DEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	>=dev-libs/gobject-introspection-1.35.0
	>=media-libs/gstreamer-1.18
	>=gui-libs/gtk-4.17.5:4
	>=gui-libs/libadwaita-1.7:1
	net-libs/libsoup:3.0
	app-text/libspelling:1
	"
RDEPEND="
	${DEPEND}
	$(python_gen_cond_dep '
		>=dev-python/pygobject-3.51:3[${PYTHON_USEDEP}]
		>=dev-python/beautifulsoup4-4.14.3[${PYTHON_USEDEP}]
		>=dev-python/certifi-2026.4.22[${PYTHON_USEDEP}]
		>=dev-python/charset-normalizer-3.4.7[${PYTHON_USEDEP}]
		>=dev-python/click-8.1.8[${PYTHON_USEDEP}]
		>=dev-python/colorama-0.4.6[${PYTHON_USEDEP}]
		>=dev-python/gtts-2.5.4[${PYTHON_USEDEP}]
		>=dev-python/idna-3.14[${PYTHON_USEDEP}]
		>=dev-python/requests-2.33.1[${PYTHON_USEDEP}]
		>=dev-python/soupsieve-2.8.3[${PYTHON_USEDEP}]
		>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
		>=dev-python/urllib3-2.7.0[${PYTHON_USEDEP}]
	')
"

BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
	dev-util/blueprint-compiler
"

src_prepare() {
	default
	xdg_environment_reset

	rm -rf po || die
	mv "${WORKDIR}/po-${PV}" "${S}/po" || die
}

src_configure() {
	python_setup

	local emesonargs=(
		-Dprofile=default
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	python_fix_shebang "${ED}/usr/bin/dialect"
	python_optimize "${ED}/usr/share/dialect"
}
