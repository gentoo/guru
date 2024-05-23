# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Keyboard driven and lightweight Wayland notification daemon."
HOMEPAGE="https://codeberg.org/dnkl/fnott"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fnott.git"
else
	SRC_URI="https://codeberg.org/dnkl/fnott/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT ZLIB"
SLOT="0"

DEPEND="
	x11-libs/pixman
	media-libs/libpng
	dev-libs/wayland
	sys-apps/dbus
	media-libs/fcft
	media-libs/freetype
	media-libs/fontconfig
"
RDEPEND="${DEPEND}
"
BDEPEND="
	dev-util/wayland-scanner
	dev-libs/wayland-protocols
	app-text/scdoc
	dev-libs/tllist
"

src_install() {
	local DOCS=( CHANGELOG.md README.md LICENSE )
	meson_src_install

	rm -r "${ED}"/usr/share/doc/"${PN}" || die
}
