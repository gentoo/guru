# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://codeberg.org/dnkl/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
else
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/${PN}.git"
fi

DESCRIPTION="Simplistic and highly configurable status panel for X and Wayland"
HOMEPAGE="https://codeberg.org/dnkl/yambar"
LICENSE="MIT"
SLOT="0"
IUSE="wayland X"
REQUIRED_USE="|| ( wayland X )"

RDEPEND="
	>=media-libs/fcft-2.4.0
	dev-libs/json-c
	dev-libs/libyaml
	media-libs/alsa-lib
	media-libs/libmpdclient
	virtual/libudev:=
	x11-libs/pixman
	wayland? ( dev-libs/wayland )
	X? (
		x11-libs/libxcb:0=[xkb]
		x11-libs/xcb-util
		x11-libs/xcb-util-cursor
		x11-libs/xcb-util-wm
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-text/scdoc
	>=dev-libs/tllist-1.0.1
	>=dev-util/meson-0.53.0
	virtual/pkgconfig
	wayland? (
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
	)
"

src_configure() {
	local emesonargs=(
		$(meson_feature wayland backend-wayland)
		$(meson_feature X backend-x11)
		-Dwerror=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	rm -rf "${D}/usr/share/doc/${PN}"
}
