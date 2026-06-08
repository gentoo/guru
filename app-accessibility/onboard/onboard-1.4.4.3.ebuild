# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{8..14} )

inherit distutils-r1 gnome2-utils udev xdg

DESCRIPTION="An onscreen keyboard useful for tablet PC users and for mobility impaired users"
HOMEPAGE="https://launchpad.net/onboard https://github.com/onboard-osk/onboard"

VER1="${PV%.*}"
VER2="${PV##*.}"
UPSTREAM_VER="${VER1}-${VER2}"

SRC_URI="https://github.com/onboard-osk/${PN}/archive/refs/tags/v${UPSTREAM_VER}.tar.gz -> ${PN}-v${UPSTREAM_VER}.tar.gz"

S="${WORKDIR}/${PN}-${UPSTREAM_VER}"
# po/* are licensed under BSD 3-clause
LICENSE="GPL-3+ BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+accessibility wayland X"

COMMON_DEPEND="app-text/hunspell:=
	dev-libs/dbus-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	gnome-base/dconf
	gnome-base/gsettings-desktop-schemas
	gnome-base/librsvg
	media-libs/libcanberra
	x11-libs/gtk+:3[introspection]
	X? (
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXtst
		x11-libs/libwnck:3
	)
	x11-libs/pango"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool"
RDEPEND="${COMMON_DEPEND}
	app-text/iso-codes
	accessibility? (
		app-accessibility/at-spi2-core:2
		gnome-extra/mousetweaks
	)
	wayland? (
		app-accessibility/at-spi2-core:2
		gui-libs/gtk-layer-shell
	)
	X? (
		x11-libs/libxkbfile
	)"

RESTRICT="mirror test"

python_prepare_all() {
	gnome2_environment_reset
	distutils-r1_python_prepare_all
}

src_compile() {
	export FAKEROOTKEY=gentoo-ebuild
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
	mv "${D}"/usr/share/doc/onboard "${D}"/usr/share/doc/"${P}"

	insinto /etc/xdg/autostart/
	doins "${S}"/build/share/autostart/onboard-autostart.desktop

	if use wayland; then
		insinto /usr/lib/udev/rules.d/
		doins "${S}"/data/72-onboard-uinput.rules
	fi
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	udev_reload
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
	udev_reload
}
