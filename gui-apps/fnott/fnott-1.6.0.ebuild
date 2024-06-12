# Copyright 2022-2024 Gentoo Authors
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

RDEPEND="
	dev-libs/wayland
	media-libs/fcft
	media-libs/freetype
	media-libs/libpng
	sys-apps/dbus
	x11-libs/pixman
	media-libs/fontconfig
"
DEPEND="
	${RDEPEND}
	dev-libs/tllist
"
BDEPEND="
	dev-util/wayland-scanner
	>=dev-libs/wayland-protocols-1.32
	app-text/scdoc
"

src_install() {
	local DOCS=( CHANGELOG.md README.md )
	meson_src_install

	rm -r "${ED}"/usr/share/doc/"${PN}" || die
}
