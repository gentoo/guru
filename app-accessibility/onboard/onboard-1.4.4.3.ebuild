# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature gnome2 udev xdg

DESCRIPTION="An onscreen keyboard useful for tablet PC users and for mobility impaired users"
HOMEPAGE="https://github.com/onboard-osk/onboard"

MY_PV=$(ver_rs 3 '-')

SRC_URI="https://github.com/onboard-osk/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${PN}-v${MY_PV}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"
# po/* are licensed under BSD 3-clause
LICENSE="GPL-3+ BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="wayland X"

COMMON_DEPEND="app-text/hunspell:=
	dev-libs/dbus-glib
	dev-libs/glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	gnome-base/dconf
	gnome-base/gsettings-desktop-schemas
	gnome-base/librsvg
	media-libs/libcanberra
	virtual/libudev
	x11-libs/cairo
	x11-libs/gtk+:3[introspection]
	x11-libs/libXtst
	x11-libs/libxkbfile
	x11-libs/pango
	X? (
		x11-libs/libX11
		x11-libs/libXi

		x11-libs/libwnck:3
	)"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool"
RDEPEND="${COMMON_DEPEND}
	app-text/iso-codes
	wayland? (
		app-accessibility/at-spi2-core:2
		gui-libs/gtk-layer-shell
	)"

RESTRICT="mirror test"

python_prepare_all() {
	gnome2_environment_reset
	distutils-r1_python_prepare_all
}

src_configure() {
	distutils-r1_src_configure
}

src_compile() {
	export FAKEROOTKEY=gentoo-ebuild
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
	mv "${D}"/usr/share/doc/onboard "${D}"/usr/share/doc/"${P}" || die

	insinto /etc/xdg/autostart/
	doins "${S}"/build/share/autostart/onboard-autostart.desktop

	if use wayland; then
		insinto /usr/lib/udev/rules.d/
		doins "${S}"/data/72-onboard-uinput.rules
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst
	udev_reload
	optfeature "Mouse accessibility enhancements for the GNOME desktop" gnome-extra/mousetweaks
}

pkg_postrm() {
	gnome2_pkg_postrm
	udev_reload
}
