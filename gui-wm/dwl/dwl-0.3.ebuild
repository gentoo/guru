# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic savedconfig toolchain-funcs

DESCRIPTION="dwm for Wayland"
HOMEPAGE="https://github.com/djpohly/dwl"
SRC_URI="https://github.com/djpohly/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0 GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

RDEPEND="
	dev-libs/libinput
	dev-libs/wayland
	gui-libs/wlroots[X(-)?]
	x11-libs/libxcb
	x11-libs/libxkbcommon
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	default

	restore_config config.h
}

src_configure() {
	use X && append-cppflags -DXWAYLAND
	tc-export CC
}

src_install() {
	emake PREFIX="${ED}/usr" install

	insinto /usr/share/wayland-sessions
	doins "${FILESDIR}"/dwl.desktop

	einstalldocs

	save_config config.h
}
