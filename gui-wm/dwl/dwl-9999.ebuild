# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig git-r3 flag-o-matic

DESCRIPTION="dwm for Wayland"
HOMEPAGE="https://github.com/djpohly/dwl"
EGIT_REPO_URI="https://github.com/djpohly/dwl"

LICENSE="CC0-1.0 GPL-3 MIT"
SLOT="0"
KEYWORDS=""
IUSE="X"

RDEPEND="
	dev-libs/libinput
	dev-libs/wayland
	x11-libs/libxcb
	x11-libs/libxkbcommon
	>=gui-libs/wlroots-0.15:=[X(-)?]
	<gui-libs/wlroots-0.16:=[X(-)?]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	restore_config config.h

	default
}

src_configure() {
	use X && append-cflags $(test-flags-CC -DXWAYLAND)
	append-cflags $(test-flags-CC -Wno-unused-result)
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	insinto /usr/share/wayland-sessions
	doins "${FILESDIR}"/dwl.desktop

	einstalldocs

	save_config config.h
}
