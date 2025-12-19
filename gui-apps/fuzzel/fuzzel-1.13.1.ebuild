# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson optfeature

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
IUSE="png svg"

DEPEND="
	dev-libs/wayland
	<media-libs/fcft-4.0.0
	>=media-libs/fcft-3.0.0
	media-libs/fontconfig
	x11-libs/libxkbcommon
	x11-libs/pixman
	png? ( media-libs/libpng )
	svg? ( media-libs/nanosvg )
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
		-Dsvg-backend=$(usex svg nanosvg none)
		$(meson_feature svg system-nanosvg)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	rm -rf "${ED}/usr/share/doc/fuzzel" || die
}

pkg_postinst() {
	optfeature "For rounded corner support" x11-libs/cairo
}
