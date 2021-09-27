# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig git-r3

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
	>=gui-libs/wlroots-0.14:=[X(-)?]
	<gui-libs/wlroots-0.15:=[X(-)?]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	restore_config config.h

	use X && eapply "${FILESDIR}"/enable-xwayland.patch

	default
}

src_install() {
	emake PREFIX="${ED}/usr" install

	insinto /usr/share/wayland-sessions
	doins "${FILESDIR}"/dwl.desktop

	einstalldocs

	save_config config.h
}
