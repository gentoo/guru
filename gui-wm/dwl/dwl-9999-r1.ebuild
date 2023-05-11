# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic savedconfig toolchain-funcs

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/djpohly/dwl"
	inherit git-r3

	# 9999-r0: main (latest wlroots release)
	# 9999-r1: wlroots-next (wlroots-9999)
	case ${PVR} in
		9999)
			EGIT_BRANCH=main
			WLROOTS_SLOT="0/16"
			;;
		9999-r1)
			EGIT_BRANCH=wlroots-next
			WLROOTS_SLOT="0/9999"
			;;
	esac
else
	WLROOTS_SLOT="0/16"
	SRC_URI="https://github.com/djpohly/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="dwm for Wayland"
HOMEPAGE="https://github.com/djpohly/dwl"

LICENSE="CC0-1.0 GPL-3 MIT"
SLOT="0"
IUSE="X"

RDEPEND="
	dev-libs/libinput:=
	dev-libs/wayland
	gui-libs/wlroots:${WLROOTS_SLOT}[X(-)?]
	x11-libs/libxkbcommon
	X? (
		x11-libs/libxcb:=
		x11-libs/xcb-util-wm
	)
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
	sed -i "s:/local::g" config.mk || die

	sed -i "s:pkg-config:$(tc-getPKG_CONFIG):g" config.mk || die

	tc-export CC

	if use X; then
		append-cppflags '-DXWAYLAND'
		append-libs '-lxcb' '-lxcb-icccm'
	fi
}

src_install() {
	default

	insinto /usr/share/wayland-sessions
	doins "${FILESDIR}"/dwl.desktop

	save_config config.h
}
