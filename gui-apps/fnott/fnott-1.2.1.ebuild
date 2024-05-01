# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EMESON_BUILDTYPE="release"

inherit meson

DESCRIPTION="Keyboard driven and lightweight Wayland notification daemon."
HOMEPAGE="https://codeberg.org/dnkl/fnott"
SRC_URI="https://codeberg.org/dnkl/fnott/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/pixman
	media-libs/libpng
	dev-libs/wayland
	sys-apps/dbus
	media-libs/fcft
	media-libs/freetype
	media-libs/fontconfig
	dev-libs/wayland-protocols
"
RDEPEND="${DEPEND}
"
BDEPEND="
	dev-util/wayland-scanner
	app-text/scdoc
	dev-libs/tllist
"

src_install() {
	local DOCS=( CHANGELOG.md README.md )
	meson_src_install

	rm -r "${ED}"/usr/share/doc/"${PN}" || die
}
