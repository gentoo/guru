# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://github.com/riverwm/river"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/riverwm/river"
else
 	SRC_URI="https://github.com/riverwm/river/releases/download/v${PV}/river-${PV}.tar.gz"
fi

PATCHES=()

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-libs/libxkbcommon
		dev-libs/libevdev
		x11-libs/pixman
		virtual/pkgconfig
		app-text/scdoc
		dev-libs/wayland
		dev-libs/wayland-protocols
		>gui-libs/wlroots-0.16"
RDEPEND="${DEPEND}"
BDEPEND="=dev-lang/zig-0.9.1-r3"

src_install() {
	zig build -Drelease-safe --prefix "${D}/usr" install

	dodir /usr/share/examples/river

	cp "${S}/example/init" "${D}/usr/share/examples/river/init"
}
