# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/DreamMaoMao/maomaowm.git"
	inherit git-r3
else
	SRC_URI="https://github.com/DreamMaoMao/${PN}/archive/${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm64"
fi

DESCRIPTION="wayland compositor based on wlroots and scenefx(dwl but no suckless)"
HOMEPAGE="https://github.com/DreamMaoMao/maomaowm.git"

LICENSE="CC0-1.0 GPL-3+ MIT"
SLOT="0"
IUSE="X"

COMMON_DEPEND="
	>=gui-libs/wlroots-0.19:=[libinput,session,X?]
	<gui-libs/wlroots-0.20:=[X?]
"

COMMON_DEPEND+="
	dev-libs/libinput:=
	dev-libs/wayland
	>=gui-libs/scenefx-0.4.1
	dev-libs/libpcre2
	x11-libs/libxkbcommon
	X? (
		x11-libs/libxcb:=
		x11-libs/xcb-util-wm
	)
"

RDEPEND="
	${COMMON_DEPEND}
	X? (
		x11-base/xwayland
	)
"

# uses <linux/input-event-codes.h>
DEPEND="
	${COMMON_DEPEND}
	sys-kernel/linux-headers
"

BDEPEND="
	>=dev-libs/wayland-protocols-1.32
	>=dev-util/wayland-scanner-1.23
	>=dev-build/meson-0.60.0
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
		)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
