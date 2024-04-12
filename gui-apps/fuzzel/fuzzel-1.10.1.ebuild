# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fuzzel.git"
else
	SRC_URI="https://codeberg.org/dnkl/fuzzel/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

DESCRIPTION="Application launcher for wlroots based Wayland compositors."
HOMEPAGE="https://codeberg.org/dnkl/fuzzel"
LICENSE="MIT"
SLOT="0"
IUSE="cairo png svg"

DEPEND="
	dev-libs/wayland
	<media-libs/fcft-4.0.0
	>=media-libs/fcft-3.0.0
	x11-libs/libxkbcommon
	x11-libs/pixman
	cairo? ( x11-libs/cairo )
	png? ( media-libs/libpng )
	svg? ( gnome-base/librsvg )
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
	>=dev-libs/tllist-1.0.1
	>=dev-libs/wayland-protocols-1.32
	dev-util/wayland-scanner
"

src_configure() {
	local emesonargs=(
		-Dpng-backend=$(usex png libpng none)
		-Dsvg-backend=$(usex svg librsvg none)
		$(meson_feature cairo enable-cairo)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	rm -rf "${ED}/usr/share/doc/fuzzel" || die
}
