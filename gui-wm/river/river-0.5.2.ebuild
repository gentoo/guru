# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -g -r -A ZBS_DEPENDENCIES=(
	[pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.3.0.tar.gz'
	[wayland-0.7.0-lQa1kuP8AQD5dW7_o-VKLVD_QbqXe7Zob78r2su7Pyex.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.7.0.tar.gz'
	[wlroots-0.20.3-jmOlcsh0BACce9rpfvzUI4V3AalGg9GE0QQkvRFoHo1c.tar.gz]='https://codeberg.org/ifreund/zig-wlroots/archive/v0.20.3.tar.gz'
	[xkbcommon-0.5.0-VDqIe8y3AgDU-cGL02xZplwABH3WbpTimrrgbgTgD_3g.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.5.0.tar.gz'
)
ZIG_SLOT="0.17"

inherit eapi9-ver zig

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/ https://codeberg.org/river/river"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/river/river.git"
else
	# TODO verify-sig support
	SRC_URI="
		https://codeberg.org/river/river/releases/download/v${PV}/${P}.tar.gz
		${ZBS_DEPENDENCIES_SRC_URI}
	"
	KEYWORDS="~amd64 ~arm64"
fi

# river: GPL-3-or-later
# zig-pixman, zig-wayland, zig-wlroots, zig-xkbcommon: MIT
LICENSE="GPL-3+ MIT"
SLOT="0"
IUSE="X man"

BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	man? ( app-text/scdoc )
	|| (
		dev-lang/zig:${ZIG_SLOT}
		dev-lang/zig-bin:${ZIG_SLOT}
	)
"
DEPEND="
	dev-libs/libevdev
	dev-libs/libinput:=
	dev-libs/wayland
	gui-libs/wlroots:0.20[X?]
	x11-libs/libxkbcommon[wayland,X?]
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

DOCS=( "README.md" )

BUILD_DIR="${S}"

src_unpack() {
	if [[ "${PV}" == "9999" ]]; then
		git-r3_src_unpack
		zig_live_src_unpack
	else
		zig_src_unpack
	fi
}

src_configure() {
	local my_zbs_args=(
		-Dstrip=false # Let Portage control this
		-Dpie=true
		-Dllvm=$(usex amd64 false true)
		-Dman-pages=$(usex man true false)
		-Dxwayland=$(usex X true false)
	)

	zig_src_configure
}

src_install() {
	zig_src_install

	insinto /usr/share/wayland-sessions/
	doins contrib/river.desktop
}

pkg_postinst() {
	if ver_replacing -lt 0.4; then
		ewarn "River 0.4.x is a significant rework of the compositor's architecture,"
		ewarn "and requires significant manual migration. If you would like to stay on"
		ewarn "river 0.3.x, simply add '>=gui-wm/river-0.4' to your package.mask to"
		ewarn "use river-classic continuation of the 0.3.x branch."
	fi

	einfo "River requires an separate window manager in addition to the main"
	einfo "compositor. For some options, see gui-wm/canoe and gui-wm/kwm."
}
